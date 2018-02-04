class API::AccountsController < ApplicationController
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
    params.require(:account).permit(:country, :email, :account_type, :account_id)
  end

  def createAccount(account)
    Stripe::Account.create(
      country: account.country,
      email: account.email,
      type: account.account_type
    )

    id = get_account_id
    account.update_attribute(:account_id, id)

    mail = AccountMailer.new_account(account).deliver_later

    # delete this line unless you want to see outgoing mail in logs
    puts mail
  end

  def get_account_id
    list = Stripe::Account.list
    list["data"].first.id
  end
end
