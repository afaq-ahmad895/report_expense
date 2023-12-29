class ExpensesController < ApplicationController
  require 'pry'
   before_action :authenticate_user!
  # before_action :authenticate_user!, only: [:create, :update, :destroy]
   before_action :set_expense, only: [:show, :edit, :update, :destroy]
    def index
      # if current_user
        #  @expense = Expense.all
        
         @expenses = current_user.expenses
        #  else
          
        #   redirect_to new_user_session_path
        # end
    end

    def new
     @expense = Expense.new
    end


    def create
        #  @expense = Expense.new(expense_params)
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


