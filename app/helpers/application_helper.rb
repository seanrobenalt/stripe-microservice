module ApplicationHelper
  def get_your_balance
    Stripe::Balance.retrieve()
  end

  def past_ten_events
    Stripe::Event.list(limit: 10)
  end

  def past_ten_payouts
    Stripe::Payout.list(limit: 10)
  end

  def all_customers
    Stripe::Customer.list
  end

  def past_ten_charges
    Stripe::Charge.list(limit: 10)
  end

  def all_coupons
    Stripe::Coupon.list
  end
end
