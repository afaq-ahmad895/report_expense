class Expense < ApplicationRecord
    validates :name, presence: true, length: { minimum: 5 }
    validates :amount, presence: true, length: { minimum: 4 }
    belongs_to :category
    belongs_to :user

    require 'csv'
    def self.to_csv
        expenses = all
        CSV.generate do |csv|
            csv << column_names
            expenses.each do |expense|
                csv << expense.attributes.values_at(*column_names)
            end
        end
    end
end

