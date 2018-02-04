class API::PaymentsController < ApplicationController
  def create
    payment = Payment.new(payment_params)
    if payment.save!
      hitStripe(payment)
      render json: payment, status: :created
    else
      render json: {errors: payment.errors}, status: :unprocessable_entity
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:cus_id, :amount, :description, :currency, :coupon,
      :percent_off, :duration, :duration_in_months, :coupon_id)
  end

  def hitStripe(payment)
    customer = Stripe::Customer.retrieve(payment.cus_id)
    Stripe::Charge.create(
      customer: customer.id,
      source: customer.default_source,
      amount: payment.amount,
      currency: payment.currency,
      description: payment.description
    )

    if payment.coupon == true
      Stripe::Coupon.create(
        percent_off: payment.percent_off,
        duration: payment.duration,
        id: payment.coupon_id
      )
      mail = CouponMailer.send_coupon(customer, payment).deliver_later

      # delete this line unless you want to see your outgoing mail in logs
      puts mail
    end

  rescue Stripe::CardError => e
    puts e.message
  end
end
