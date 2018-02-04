class API::TransfersController < ApplicationController
  def create
    transfer = Transfer.new(transfer_params)
    if transfer.save!
      createTransfer(transfer)
      render json: transfer, status: :created
    else
      render json: {errors: transfer.errors}, status: :unprocessable_entity
    end
  end

  private

  def transfer_params
    params.require(:transfer).permit(:amount, :currency, :destination, :source_transaction)
  end

  def createTransfer(transfer)
    Stripe::Transfer.create(
      amount: transfer.amount,
      currency: transfer.currency,
      destination: transfer.destination,
      source_transaction: transfer.try!(:source_transaction)
    )

    account = Stripe::Account.retrieve(transfer.destination)
    email_recipient = account.email
    mail = TransferMailer.notify_receiver(email_recipient, transfer).deliver_later

    # delete this line unless you want to see your outgoing mail in your logs
    puts mail
  end
end
