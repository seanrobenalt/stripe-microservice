class AddCusIdToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :cus_id, :string
  end
end
