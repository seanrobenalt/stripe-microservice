class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :country
      t.string :email
      t.string :type

      t.timestamps
    end
  end
end
