class AccountMailer < ApplicationMailer

  def new_account(account)
    @account = account
    mail(to: @account.email, subject: 'You now have a Stripe account!')
  end
end
