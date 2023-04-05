class AddOrderToColumn < ActiveRecord::Migration[7.0]
  def up
    add_column :columns, :ordinal_number, :integer, default: 0
  end

  def down
    remove_column :columns, :ordinal_number, :integer
  end
end
