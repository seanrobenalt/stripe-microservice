class AddCouponFieldsToPayment < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :coupon, :boolean, default: false
    add_column :payments, :percent_off, :integer
    add_column :payments, :duration, :string
    add_column :payments, :duration_in_months, :integer
    add_column :payments, :coupon_id, :string
  end
end
