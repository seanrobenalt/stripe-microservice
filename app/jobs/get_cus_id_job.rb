class GetCusIdJob < ApplicationJob
  queue_as :hard_workers

  def perform(customer)
    current_customer = Stripe::Customer.list(email: customer.email)
    cus_id = current_customer["data"][0].id
    customer.update_attribute(:cus_id, cus_id)
  end
end
