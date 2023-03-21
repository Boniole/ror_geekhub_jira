class AddReferencesToColumns < ActiveRecord::Migration[7.0]
  def change
    add_reference :columns, :desk, null: false, foreign_key: true
  end
end
