class AddUserIdToComments < ActiveRecord::Migration[6.0]
  def up
    add_column :comments, :user_id, :bigint
    add_foreign_key :comments, :users,  on_delete: :cascade
  end

  def down
    remove_foreign_key :comments, :users,  on_delete: :cascade
    remove_column :comments, :user_id
  end
end
