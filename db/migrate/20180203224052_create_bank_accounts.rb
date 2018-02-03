class CreateBankAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :bank_accounts do |t|
      t.string :country
      t.string :currency
      t.string :account_holder_name
      t.string :account_holder_type
      t.string :routing_number
      t.string :account_number

      t.timestamps
    end
  end
end
