class RemoveDefaultFromPriorityStatusAndTypeOfInTasks < ActiveRecord::Migration[7.0]
  def change
    change_column_default :tasks, :status, from: 0, to: nil
    change_column_default :tasks, :priority, from: 0, to: nil
    change_column_default :tasks, :type_of, from: 0, to: nil
  end
end
