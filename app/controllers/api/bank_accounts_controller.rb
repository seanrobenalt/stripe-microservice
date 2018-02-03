class API::BankAccountsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_access_control_headers

  def create
    bank_account = BankAccount.new(bank_account_params)
    if bank_account.save!
      createBankAccount(bank_account)
      render json: bank_account, status: :created
    else
      render json: {errors: bank_account.errors}, status: :unprocessable_entity
    end
  end

  private

  def bank_account_params
    params.require(:bank_account).permit(:country, :currency, :account_holder_name,
      :account_holder_type, :routing_number, :account_number, :cus_id)
  end

  def createBankAccount(bank_account)
    token = Stripe::Token.create(
      bank_account: {
        country: bank_account.country,
        currency: bank_account.currency,
        account_holder_name: bank_account.account_holder_name,
        account_holder_type: bank_account.account_holder_type,
        routing_number: bank_account.routing_number,
        account_number: bank_account.account_number
      }
    )
    customer = Stripe::Customer.retrieve(bank_account.cus_id)
    bank_account = customer.sources.create(source: token)
    bank_account.verify(amounts: [32, 45])

  rescue Exception => msg
    puts msg
  end
end
