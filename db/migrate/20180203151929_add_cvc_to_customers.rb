class AddCvcToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :cvc, :integer
  end
end
