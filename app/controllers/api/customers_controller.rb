class API::CustomersController < ApplicationController
  def create
    customer = Customer.new(customer_params)
    if customer.save!
      CustomerJob.perform_later(customer)
      render json: customer, status: :created
    else
      render json: {errors: customer.errors}, status: :unprocessable_entity
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:description, :email, :exp_month, :exp_year, :card_number, :cvc, :cus_id)
  end
end
