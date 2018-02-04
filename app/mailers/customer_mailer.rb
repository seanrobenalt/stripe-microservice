class CustomerMailer < ApplicationMailer

  def new_customer(customer)
    @customer = customer
    mail(to: @customer.email, subject: 'You signed up to the Stripe microservice')
  end
end
