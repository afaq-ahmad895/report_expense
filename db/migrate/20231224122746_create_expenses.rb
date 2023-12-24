class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.string :name
      t.string :category
      t.integer :amount
      t.datetime :start_time

      t.timestamps
    end
  end
end
