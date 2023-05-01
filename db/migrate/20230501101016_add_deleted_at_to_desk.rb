class AddDeletedAtToDesk < ActiveRecord::Migration[7.0]
  def up
    add_column :desks, :deleted_at, :datetime
    add_index :desks, :deleted_at
  end

  def down
    remove_index :desks, :deleted_at
    remove_column :desks, :deleted_at
  end
end
