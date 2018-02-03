class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.integer :percent_off
      t.string :duration
      t.integer :duration_in_months
      t.string :currency
      t.integer :amount_off
      t.integer :max_redemptions
      t.datetime :redeem_by

      t.timestamps
    end
  end
end
