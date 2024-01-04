class RemoveCategoryFromExpenses < ActiveRecord::Migration[5.2]
  def change
    remove_column :expenses, :category, :string
  end
end
