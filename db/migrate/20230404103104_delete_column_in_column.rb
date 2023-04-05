class DeleteColumnInColumn < ActiveRecord::Migration[7.0]
  def up
    remove_column :columns, :desk_id
  end

  def down
    add_column :columns, :desk_id, :integer
    add_foreign_key :columns, :desks
  end
end
