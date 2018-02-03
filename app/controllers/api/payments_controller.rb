class API::PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_access_control_headers

  def create
    payment = Payment.new(payment_params)
    if payment.save!
      hitStripe(payment)
      render json: payment, status: :created
    else
      render json: {errors: payment.errors}, status: :unprocessable_entity
    end
  end

  def preflight
    head 200
  end

  private

  def payment_params
    params.require(:payment).permit(:cus_id, :amount, :description, :currency)
  end

  def hitStripe(payment)
    customer = Stripe::Customer.retrieve(payment.cus_id)
    Stripe::Charge.create(
      :customer => customer.id,
      :source => customer.default_source,
      :amount => payment.amount,
      :currency => payment.currency,
      :description => payment.description
    )

    rescue Stripe::CardError => e
      puts e.message
  end
end
