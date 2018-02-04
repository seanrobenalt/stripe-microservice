class CreateTransfers < ActiveRecord::Migration[5.1]
  def change
    create_table :transfers do |t|
      t.integer :amount
      t.string :currency
      t.string :destination
      t.string :source_transaction

      t.timestamps
    end
  end
end
