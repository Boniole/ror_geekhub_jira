class AddColumnIdToTasks < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :column, polymorphic: true, null: false
  end
end
