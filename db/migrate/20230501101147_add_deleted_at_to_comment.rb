class AddDeletedAtToComment < ActiveRecord::Migration[7.0]
  def up
    add_column :comments, :deleted_at, :datetime
    add_index :comments, :deleted_at
  end

  def down
    remove_index :comments, :deleted_at
    remove_column :comments, :deleted_at
  end
end
