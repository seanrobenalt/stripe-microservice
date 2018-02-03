class API::CustomersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_access_control_headers

  def create
    customer = Customer.new(customer_params)
    if customer.save!
      createStripeCustomer(customer)
      render json: customer, status: :created
    else
      render json: {errors: customer.errors}, status: :unprocessable_entity
    end
  end

  def preflight
    head 200
  end

  private

  def customer_params
    params.require(:customer).permit(:description, :email, :exp_month, :exp_year, :card_number, :cvc)
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

  rescue Exception => msg
      puts msg
  end
end
