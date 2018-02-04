class CreateRefunds < ActiveRecord::Migration[5.1]
  def change
    create_table :refunds do |t|
      t.string :charge_id
      t.integer :amount
      t.string :reason

      t.timestamps
    end
  end
end
