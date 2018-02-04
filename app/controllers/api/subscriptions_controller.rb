class API::SubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_access_control_headers

  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save!
      createSubscription(subscription)
      render json: subscription, status: :created
    else
      render json: {errors: subscription.errors}, status: :unprocessable_entity
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:cus_id, :plan_id)
  end

  def createSubscription(subscription)
    Stripe::Subscription.create(
      customer: subscription.cus_id,
      items: [
        {
          plan: subscription.plan_id
        }
      ]
    )

    customer = Stripe::Customer.retrieve(subscription.cus_id)
    mail = SubscriptionMailer.send_subscription_email(customer)

    # delete this line unless you want to see your emails in your logs
    puts mail
  end
end
