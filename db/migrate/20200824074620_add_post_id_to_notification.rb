class AddPostIdToNotification < ActiveRecord::Migration[6.0]
  def up
    add_column :notifications, :post_id, :bigint
    add_foreign_key :notifications, :posts,  on_delete: :cascade
  end

  def down
    remove_foreign_key :notifications, :posts,  on_delete: :cascade
    remove_column :notifications, :post_id
  end
end
