class ExpensesController < ApplicationController
  # before_action :authenticate_user!
  before_action :authenticate_user!, only: [:create, :update, :destroy]
    def index
        @expense = Expense.all
    end

    def new
     @expense = Expense.new
    end


    def create
        @expense = Expense.new(post_params)
        
        if(@expense.save)
          flash[:notice]="Expense created successfully" 
         redirect_to @expense
        else
         render 'new'
         end
        end

    def show
         @expense = Expense.find(params[:id])

    end

    def edit
        @expense = Expense.find(params[:id])

   end

   def update
    @expense=Expense.find(params[:id])
    if(@expense.update(post_params))
      flash[:notice]="Expense Updated successfully"
    redirect_to @expense
    else
    render 'edit'
    end
      end


      def destroy
        @expense=Expense.find(params[:id])
        @expense.destroy
        flash[:notice]=" Expense Deleted successfully"
        redirect_to expenses_path
          end


    private def post_params
        params.require(:expense).permit(:name , :category_id, :amount, :date_time, :start_time)
      end

end
