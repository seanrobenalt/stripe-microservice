class AddCusIdToBankAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :bank_accounts, :cus_id, :string
  end
end
