class CategoriesController < ApplicationController

  before_action :set_category, only: [:show, :edit, :update, :destroy]
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
  end

  def edit
  end

  def update
    if(@category.update(post_params))
      flash[:notice]="Category Updated successfully"
      redirect_to @category
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    flash[:notice]=" Category Deleted successfully"
    redirect_to categories_path
  end

  private
  def post_params

    params.require(:category).permit(:name)
  end

  def set_category
    @category=Category.find(params[:id])
  end
end




