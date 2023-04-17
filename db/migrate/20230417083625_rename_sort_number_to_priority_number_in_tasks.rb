class RenameSortNumberToPriorityNumberInTasks < ActiveRecord::Migration[7.0]
  def change
    rename_column :tasks, :sort_number, :priority_number
  end
end
