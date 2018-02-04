class CreatePayouts < ActiveRecord::Migration[5.1]
  def change
    create_table :payouts do |t|
      t.integer :amount
      t.string :currency
      t.string :destination
      t.string :description

      t.timestamps
    end
  end
end
