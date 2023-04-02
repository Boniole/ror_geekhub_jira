class AddDefaultValueToNameDesk < ActiveRecord::Migration[7.0]
  def up
    change_column :desks, :name, :string, default: 'Your Desk'
  end

  def down
    change_column :desks, :name, :string, default: nil
  end
end
