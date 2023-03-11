class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.text :title
      t.string :description
      t.integer :priority
      t.integer :status
      t.text :label
      t.datetime :estimate
      t.date :start
      t.date :end
      t.integer :assignee_id

      t.timestamps
    end
  end
end
