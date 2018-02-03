class API::PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_access_control_headers

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Content-Type'
  end

  def create
    app = App.find_by(url: request.env['HTTP_ORIGIN'])
    if app == nil
      render json: 'app not found', status: :unprocessable_entity
    end
    payment = Payment.new(payment_params)
    payment.app = app
    if payment.save!
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

end
