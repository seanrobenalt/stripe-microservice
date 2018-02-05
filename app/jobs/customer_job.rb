class CustomerJob < ApplicationJob
  queue_as :stripe_objects

  def perform(customer)
    token = Stripe::Token.create(
      card: {
        number: customer.card_number,
        exp_month: customer.exp_month,
        exp_year: customer.exp_year,
        cvc: customer.cvc
      }
    )
    Stripe::Customer.create(
      description: customer.description,
      email: customer.email,
      source: token
    )

    GetCusIdJob.perform_later(customer)

    mail = CustomerMailer.new_customer(customer).deliver_later

    # delete this line unless you want to view outgoing mail in logs
    puts mail

  rescue Exception => msg
    puts msg
  end
end
