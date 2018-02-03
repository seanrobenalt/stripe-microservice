class ChangeCvcToStringInCustomers < ActiveRecord::Migration[5.1]
  def change
    change_column :customers, :cvc, :string
  end
end
