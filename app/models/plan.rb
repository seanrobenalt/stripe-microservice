class Plan < ApplicationRecord
  validates :currency, presence: true, length: { is: 3 }
  validates :amount, presence: true
  validates :interval, presence: true
  validates :name, presence: true
  validates :interval_count, presence: true
  validates :statement_descriptor, length: { maximum: 22 }
end
