class ResetPassWord < ActiveRecord::Migration[6.0]
  def up
    change_table :users do |t|
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
