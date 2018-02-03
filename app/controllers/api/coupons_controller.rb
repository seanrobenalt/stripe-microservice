class API::CouponsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_access_control_headers

  def create
    coupon = Coupon.new(coupon_params)
    if coupon.save!
      createCoupon(coupon)
      render json: coupon, status: :created
    else
      render json: {errors: coupon.errors}, status: :unprocessable_entity
    end
  end

  def preflight
    head 200
  end

  private

  def coupon_params
    params.require(:coupon).permit(:percent_off, :duration, :duration_in_months, :currency,
      :amount_off, :max_redemptions, :redeem_by)
  end

  def createCoupon(coupon)
    Stripe::Coupon.create(
      percent_off: coupon.try!(:percent_off),
      duration: coupon.try!(:duration),
      duration_in_months: coupon.try!(:duration_in_months),
      currency: coupon.try!(:currency),
      amount_off: coupon.try!(:amount_off),
      max_redemptions: coupon.try!(:max_redemptions),
      redeem_by: coupon.try!(:redeem_by)
    )
  end
end
