class AddDeletedAtToProject < ActiveRecord::Migration[7.0]
  def up
    add_column :projects, :deleted_at, :datetime
    add_index :projects, :deleted_at
  end

  def down
    remove_index :projects, :deleted_at
    remove_column :projects, :deleted_at
  end
end
