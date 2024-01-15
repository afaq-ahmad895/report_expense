class ExpensesController < ApplicationController
  require 'pry'
  before_action :authenticate_user!
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  def import_data
    if params[:xlsx_file].nil? || params[:xlsx_file].blank?
      flash[:notice] = "Please choose a file before importing data."
      redirect_to new_expense_path
      return
    end

    xlsx = Roo::Spreadsheet.open(params[:xlsx_file])
    xlsx.sheet(0).each_with_index(name: 'Name', amount: 'Amount',
                                  category: 'Category', start_time: 'Start_time') do |row, row_index|

      category = Category.find_or_create_by(name: row[:category])

      next if row_index == 0 || Expense.find_by(name: row[:name]).present?

      start_time = DateTime.parse(row[:start_time])

      if Expense.create(
        name: row[:name],
        amount: row[:amount],
        category_id: category.id,
        start_time: start_time,
        user_id: current_user.id
      )
        flash[:notice] = "Expense import successfully."
      else
        flash[:alert] = "Error cannot import something is wrong"
      end
    end
    redirect_to root_path
  end
  def index
    # @expenses = Expense.all
    @expenses = current_user.expenses
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="expenses.xlsx"'
      }
      format.csv { send_data Expense.to_csv, filename: "expenses.cvs-#{Date.today}.csv"}
    end
  end

  def import
    Expense.import(params[:file], current_user)
    redirect_to root_path, notice: "Data imported as CSV"
  end

  def new
    @expense = Expense.new
  end

  def create
    # @expense = Expense.new(expense_params)
    @expense = current_user.expenses.new(expense_params)
    if(@expense.save)
      flash[:notice]="Expense created successfully"
      redirect_to @expense
    else
      render 'new'
    end
  end

  def show
    # @expense = Expense.find(params[:id])
  end

  def edit
    # @expense = Expense.find(params[:id])
  end

  def update
    #authorize! :read, @expense
    # @expense=Expense.find(params[:id])
    if(@expense.update(expense_params))
      flash[:notice]="Expense Updated successfully"
      redirect_to @expense
    else
      render 'edit'
    end
  end

  def destroy
    # @expense=Expense.find(params[:id])
    @expense.destroy
    flash[:notice]=" Expense Deleted successfully"
    redirect_to expenses_path
  end

  private
  def expense_params
    params.require(:expense).permit(:name , :category_id, :amount, :date_time, :start_time, :user_id)
  end
  def set_expense
    @expense = current_user.expenses.find(params[:id])
  end
end




















