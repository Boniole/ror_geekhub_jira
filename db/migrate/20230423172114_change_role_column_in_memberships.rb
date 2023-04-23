class ChangeRoleColumnInMemberships < ActiveRecord::Migration[7.0]
  def up
    change_table :memberships do |t|
      t.change :role, :integer, using: 'role::integer'
    end
  end

  def down
    change_table :memberships do |t|
      t.change :role, :string
    end
  end
end
