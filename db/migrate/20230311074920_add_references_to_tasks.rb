class AddReferencesToTasks < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :user, null: false, foreign_key: true
    add_reference :tasks, :project, null: false, foreign_key: true
    add_reference :tasks, :desk, null: false, foreign_key: true
  end
end
