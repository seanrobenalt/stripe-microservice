class Coupon < ApplicationRecord
  validates_inclusion_of :duration, in: %w(forever once repeating)
  validates :duration, presence: true
end
