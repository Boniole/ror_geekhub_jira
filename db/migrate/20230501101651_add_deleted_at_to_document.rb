class AddDeletedAtToDocument < ActiveRecord::Migration[7.0]
  def up
    add_column :documents, :deleted_at, :datetime
    add_index :documents, :deleted_at
  end

  def down
    remove_index :documents, :deleted_at
    remove_column :documents, :deleted_at
  end
end
