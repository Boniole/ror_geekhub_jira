class ChangeTypeReferencesColumnToDesk < ActiveRecord::Migration[7.0]
  def up
    remove_column :columns, :columnable_id, :integer, null: false
    remove_column :columns, :columnable_type, :integer, null: false
    add_reference :columns, :desk,  foreign_key: true, null: false
  end

  def down
    add_column :columns, :columnable_id, :integer, null: false
    add_column :columns, :columnable_type, :integer, null: false
    remove_reference :columns, :desk, foreign_key: true
  end
end
