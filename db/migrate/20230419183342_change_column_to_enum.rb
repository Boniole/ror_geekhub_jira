class ChangeColumnToEnum < ActiveRecord::Migration[7.0]
  def change
    change_column :memberships, :role, :integer, using: 'role::integer'
  end
end
