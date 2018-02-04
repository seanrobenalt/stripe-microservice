class API::PayoutsController < ApplicationController
  def create
    payout = Payout.new(payout_params)
    if payout.save!
      createPayout(payout)
      render json: payout, status: :created
    else
      render json: {errors: payout.errors}, status: :unprocessable_entity
    end
  end

  private

  def payout_params
    params.require(:payout).permit(:amount, :description, :destination, :currency)
  end

  def createPayout(payout)
    Stripe::Payout.create(
      amount: payout.amount,
      currency: payout.currency,
      description: payout.try!(:description),
      destination: payout.try!(:destination)
    )
  end
end
