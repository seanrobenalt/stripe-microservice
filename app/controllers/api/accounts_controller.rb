class API::AccountsController < ApplicationController
  def create
    account = Account.new(account_params)
    if account.save!
      AccountJob.perform_later(account)
      render json: account, status: :created
    else
      render json: {errors: account.errors}, status: :unprocessable_entity
    end
  end

  private

  def account_params
    params.require(:account).permit(:country, :email, :account_type, :account_id)
  end
end
