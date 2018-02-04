class BankAccount < ApplicationRecord
  validates :country, presence: true
  validates :currency, length: { is: 3 }, presence: true
  validates :routing_number, presence: true
  validates :account_number, presence: true
  validates :cus_id, presence: true
end
