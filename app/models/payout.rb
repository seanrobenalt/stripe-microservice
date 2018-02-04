class Payout < ApplicationRecord
  validates :amount, presence: true
  validates :currency, length: { is: 3 }, presence: true
end
