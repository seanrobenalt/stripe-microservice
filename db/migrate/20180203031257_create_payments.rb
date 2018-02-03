class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.string :cus_id
      t.integer :amount
      t.string :description
      t.string :currency

      t.timestamps
    end
  end
end
