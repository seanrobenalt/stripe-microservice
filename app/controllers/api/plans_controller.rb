class API::PlansController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_access_control_headers

  def create
    plan = Plan.new(plan_params)
    if plan.save!
      createPlan(plan)
      render json: plan, status: :created
    else
      render json: {errors: plan.errors}, status: :unprocessable_entity
    end
  end

  def preflight
    head 200
  end

  private

  def plan_params
    params.require(:plan).permit(:currency, :interval, :name, :amount, :interval_count, :statement_descriptor)
  end

  def createPlan(plan)
    Stripe::Plan.create(
      amount: plan.amount,
      interval: plan.interval,
      name: plan.name,
      currency: plan.currency,
      interval_count: plan.interval_count,
      statement_descriptor: plan.statement_descriptor
    )
  end
end
