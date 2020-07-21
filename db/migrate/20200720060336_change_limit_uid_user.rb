class ChangeLimitUidUser < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :uid, :string
  end

  def down
    change_column :users, :uid, :integer, limit: 4
  end
end
