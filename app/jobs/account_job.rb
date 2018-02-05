class AccountJob < ApplicationJob
  queue_as :stripe_objects

  def perform(account)
    Stripe::Account.create(
      country: account.country,
      email: account.email,
      type: account.account_type
    )

    GetAccountIdJob.perform_later(account)

    mail = AccountMailer.new_account(account).deliver_later

    # delete this line unless you want to see outgoing mail in logs
    puts mail
  end
end
