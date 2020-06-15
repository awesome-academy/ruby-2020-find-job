class AddDefaultStatusProfile < ActiveRecord::Migration[6.0]
  def change
    change_column_default(
      :profiles,
      :status,
      from: nil,
      to: 0
    )
    change_column_null :profiles, :status, false
  end
end
