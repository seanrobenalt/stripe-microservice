class TransferMailer < ApplicationMailer

  def notify_receiver(email_recipient, transfer)
    @transfer = transfer
    mail(to: email_recipient, subject: 'You got transferred cash!')
  end
end
