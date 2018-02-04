class Payment < ApplicationRecord
  validates :amount, length: { minimum: 5 }, presence: true
  validates :currency, length: { is: 3 }, presence: true
  validates :cus_id, presence: true
end
