class API::AccountsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_access_control_headers

  def create
    account = Account.new(account_params)
    if account.save!
      createAccount(account)
      render json: account, status: :created
    else
      render json: {errors: account.errors}, status: :unprocessable_entity
    end
  end

  private

  def account_params
    params.require(:account).permit(:country, :email, :account_type)
  end

  def createAccount(account)
    Stripe::Account.create(
      country: account.country,
      email: account.email,
      type: account.account_type
    )
  end
end
