class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.text :title
      t.string :description
      t.integer :priority, default: 0
      t.integer :status, default: 0
      t.integer :type_of, default: 0
      t.text :label
      t.text :estimate
      t.text :start
      t.text :end
      t.integer :assignee_id

      t.timestamps
    end
  end
end
