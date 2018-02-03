class ChangeTypeColumnInAccounts < ActiveRecord::Migration[5.1]
  def change
    rename_column :accounts, :type, :account_type
  end
end
