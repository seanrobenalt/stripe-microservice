class Transfer < ApplicationRecord
  validates :amount, presence: true
  validates :currency, length: { is: 3 }, presence: true
  validates :destination, presence: true
end
