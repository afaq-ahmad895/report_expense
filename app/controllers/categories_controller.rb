class CategoriesController < ApplicationController
    def index
        @category = Category.all
    end

    def new
     @category = Category.new
    end


    def create
        @category = Category.new(post_params)
        
        if(@category.save)
          flash[:notice]="Category created successfully" 
         redirect_to @category
        else
         render 'new'
         end
        end

    def show
         @category = Category.find(params[:id])

    end

    def edit
        @category = Category.find(params[:id])

   end

   def update
    @category= Category.find(params[:id])
    if(@category.update(post_params))
      flash[:notice]="Category Updated successfully"
    redirect_to @category
    else
    render 'edit'
    end
      end


      def destroy
        @category=Category.find(params[:id])
        @category.destroy
        flash[:notice]=" Category Deleted successfully"
        redirect_to categories_path
          end


    private def post_params
        params.require(:category).permit(:name)
          end
end
