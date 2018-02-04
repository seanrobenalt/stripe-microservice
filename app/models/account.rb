class Account < ApplicationRecord
  validates :account_type, presence: true
  validates :email, presence: true, if: :standard_account?

  def standard_account?
    account_type == 'standard'
  end
end
