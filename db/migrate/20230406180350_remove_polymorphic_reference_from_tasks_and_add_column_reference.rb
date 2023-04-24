class RemovePolymorphicReferenceFromTasksAndAddColumnReference < ActiveRecord::Migration[7.0]
  def change
    remove_reference :tasks, :column, polymorphic: true
    add_reference :tasks, :column, null: false, foreign_key: true
  end
end
