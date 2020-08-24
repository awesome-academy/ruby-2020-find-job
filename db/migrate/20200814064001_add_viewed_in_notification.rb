class AddViewedInNotification < ActiveRecord::Migration[6.0]
  def up
    add_column :notifications, :viewed, :boolean, null: false, default: false
  end
end
