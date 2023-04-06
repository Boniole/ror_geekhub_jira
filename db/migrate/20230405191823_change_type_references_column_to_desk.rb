class ChangeTypeReferencesColumnToDesk < ActiveRecord::Migration[7.0]
  def up
    remove_reference :columns, :columnable, polymorphic: true, index: true
    add_reference :columns, :desk, foreign_key: true, null: false
  end

  def down
    remove_reference :columns, :desk, foreign_key: true
    add_reference :columns, :columnable, polymorphic: true, index: true, null: false
  end
end
