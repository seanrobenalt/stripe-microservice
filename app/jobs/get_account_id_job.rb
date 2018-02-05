class GetAccountIdJob < ApplicationJob
  queue_as :hard_workers

  def perform(account)
    list = Stripe::Account.list
    account_id = list["data"].first.id
    account.update_attribute(:account_id, account_id)
  end
end
