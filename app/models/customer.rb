class Customer < ApplicationRecord
  validates :email, presence: true
  validates :card_number, presence: true
  validates :exp_month, presence: true
  validates :exp_year, presence: true
  validates :cvc, presence: true
end
