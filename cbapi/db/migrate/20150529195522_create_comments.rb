class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comments
      t.integer :account_id
      t.timestamps null: false
    end
  end
end
