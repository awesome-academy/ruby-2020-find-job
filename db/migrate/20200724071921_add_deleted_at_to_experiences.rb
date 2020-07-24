class AddDeletedAtToExperiences < ActiveRecord::Migration[6.0]
  def change
    add_column :experiences, :deleted_at, :datetime
    add_index :experiences, :deleted_at
  end
end
