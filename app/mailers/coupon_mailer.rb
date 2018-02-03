class CouponMailer < ApplicationMailer

  def send_coupon(customer, object)
    @customer = customer
    @coupon = object
    mail(to: @customer.email, subject: 'You got sent a gift card!')
  end
end
