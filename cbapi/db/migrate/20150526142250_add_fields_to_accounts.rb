class AddFieldsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :name, :string
    add_column :accounts, :balance, :float
    add_column :accounts, :status, :string
    add_column :accounts, :user_id, :integer
  end
end
