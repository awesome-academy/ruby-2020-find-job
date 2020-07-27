class AddDeletedAtToProfileSkills < ActiveRecord::Migration[6.0]
  def change
    add_column :profile_skills, :deleted_at, :datetime
    add_index :profile_skills, :deleted_at
  end
end
