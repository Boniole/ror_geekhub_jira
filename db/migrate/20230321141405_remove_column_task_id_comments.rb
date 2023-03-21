class RemoveColumnTaskIdComments < ActiveRecord::Migration[7.0]
  def change
    remove_column :comments, :task_id
  end
end
