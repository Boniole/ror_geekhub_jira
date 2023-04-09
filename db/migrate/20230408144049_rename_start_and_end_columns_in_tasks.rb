class RenameStartAndEndColumnsInTasks < ActiveRecord::Migration[7.0]
  def change
    rename_column :tasks, :start, :start_date
    rename_column :tasks, :end, :end_date
  end
end
