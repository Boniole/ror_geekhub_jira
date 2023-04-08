class AddSortNumberToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :sort_number, :integer
  end
end
