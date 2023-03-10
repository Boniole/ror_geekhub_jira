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
      # t.references :project, null: false, foreign_key: true
      # t.references :desk, null: false, foreign_key: true
      # t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
