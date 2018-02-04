class SubscriptionMailer < ApplicationMailer

  def send_subscription_email(customer)
    @customer = customer
    mail(to: @customer.email, subject: 'You subscribed to a new plan!')
  end
end
