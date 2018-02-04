class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.string :plan_id
      t.string :cus_id

      t.timestamps
    end
  end
end
