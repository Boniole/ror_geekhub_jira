class AddDeletedAtToMembership < ActiveRecord::Migration[7.0]
  def up
    add_column :memberships, :deleted_at, :datetime
    add_index :memberships, :deleted_at
  end

  def down
    remove_index :memberships, :deleted_at
    remove_column :memberships, :deleted_at
  end
end
