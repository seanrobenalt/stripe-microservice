class AdminMailer < ApplicationMailer
  include ApplicationHelper

  def send_all_stats
    @balance = get_your_balance
    @recent_events = past_ten_events
    @recent_payouts = past_ten_payouts
    @customers = all_customers
    @recent_charges = past_ten_charges
    @coupons = all_coupons

    admin_email = ENV['ADMIN_EMAIL']

    mail(to: admin_email, subject: 'Your numbers for the week')
  end
end
