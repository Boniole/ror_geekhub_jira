class AddFieldTimeWorkToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :time_work, :string
  end
end
