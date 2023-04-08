class AddTagNameToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :tag_name, :text
  end
end
