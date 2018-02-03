class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :description
      t.string :email
      t.integer :exp_month
      t.integer :exp_year
      t.string :card_number

      t.timestamps
    end
  end
end
