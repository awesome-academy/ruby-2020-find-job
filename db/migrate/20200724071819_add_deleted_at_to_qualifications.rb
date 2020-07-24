class AddDeletedAtToQualifications < ActiveRecord::Migration[6.0]
  def change
    add_column :qualifications, :deleted_at, :datetime
    add_index :qualifications, :deleted_at
  end
end
