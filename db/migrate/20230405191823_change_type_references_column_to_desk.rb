class ChangeTypeReferencesColumnToDesk < ActiveRecord::Migration[7.0]
  def up
    add_reference :columns, :desk, foreign_key: true, null: false
  end

  def down
    add_reference :columns, :columnable, polymorphic: true, index: true, null: false
  end
end
