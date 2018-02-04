class Refund < ApplicationRecord
  validates :charge_id, presence: true
  validates_inclusion_of :reason, in: %w(duplicate fraudulent requested_by_customer)
end
