class Coupon < ApplicationRecord
  validates_inclusion_of :duration, in: %w(forever once repeating)
  validates :duration, presence: true
  validates :amount_off, presence: true
  validates :currency, length: { is: 3 }, presence: true
end
