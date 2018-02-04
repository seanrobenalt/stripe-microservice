class Subscription < ApplicationRecord
  validates :cus_id, presence: true
  validates :plan_id, presence: true
end
