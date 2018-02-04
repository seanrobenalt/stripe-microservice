class AddAccountIdToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :account_id, :string
  end
end
