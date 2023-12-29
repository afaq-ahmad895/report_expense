class Expense < ApplicationRecord
    validates :name, presence: true, length: { minimum: 5 }
    validates :amount, presence: true, length: { minimum: 4 }

    belongs_to :category

    belongs_to :user
end
