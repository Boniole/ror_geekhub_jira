class AddDefaultValueToNameDesk < ActiveRecord::Migration[7.0]
  def change
    change_column :desks, :name, :string, default: 'Your Desk'
  end
end
