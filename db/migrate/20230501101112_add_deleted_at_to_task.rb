class AddDeletedAtToTask < ActiveRecord::Migration[7.0]
  def up
    add_column :tasks, :deleted_at, :datetime
    add_index :tasks, :deleted_at
  end

  def down
    remove_index :tasks, :deleted_at
    remove_column :tasks, :deleted_at
  end
end
