class EditFieldInComments < ActiveRecord::Migration
  def change
    remove_column :comments, :comments
    add_column :comments, :content, :text
  end
end
