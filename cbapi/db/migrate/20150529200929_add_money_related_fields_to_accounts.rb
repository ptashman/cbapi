class AddMoneyRelatedFieldsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :due_date, :datetime
    add_column :accounts, :total_spent, :float
    add_column :accounts, :in_collections, :boolean, default: false
  end
end
