class Account < ApplicationRecord
  validates :account_type, presence: true
  validates_inclusion_of :account_type, in: %w(custom standard)
  validates :email, presence: true, if: :standard_account?

  def standard_account?
    account_type == 'standard'
  end
end
