class Payment < ApplicationRecord
  validates :amount, presence: true
  validates :currency, length: { is: 3 }, presence: true
  validates :cus_id, presence: true
end
