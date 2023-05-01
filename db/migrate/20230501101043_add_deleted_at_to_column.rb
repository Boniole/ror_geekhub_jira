class AddDeletedAtToColumn < ActiveRecord::Migration[7.0]
  def up
    add_column :columns, :deleted_at, :datetime
    add_index :columns, :deleted_at
  end

  def down
    remove_index :columns, :deleted_at
    remove_column :columns, :deleted_at
  end
end
