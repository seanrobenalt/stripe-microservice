class API::CustomersController < ApplicationController
  def create
    customer = Customer.new(customer_params)
    if customer.save!
      createStripeCustomer(customer)
      render json: customer, status: :created
    else
      render json: {errors: customer.errors}, status: :unprocessable_entity
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:description, :email, :exp_month, :exp_year, :card_number, :cvc, :cus_id)
  end

  def createStripeCustomer(customer)
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

    new_cus_id = get_cus_id(customer)
    customer.update_attribute(:cus_id, new_cus_id)

    mail = CustomerMailer.new_customer(customer).deliver_later

    # delete this line unless you want to view outgoing mail in logs
    puts mail

  rescue Exception => msg
    puts msg
  end

  def get_cus_id(customer)
    current_custo = Stripe::Customer.list(email: customer.email)
    current_custo["data"][0].id
  end
end
