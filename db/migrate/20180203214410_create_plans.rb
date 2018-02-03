class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.string :currency
      t.string :interval
      t.string :name
      t.integer :amount
      t.integer :interval_count
      t.string :statement_descriptor

      t.timestamps
    end
  end
end
