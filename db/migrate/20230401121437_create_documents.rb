class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :task, null: true, foreign_key: true
      t.references :comment, null: true, foreign_key: true
      t.string :name, null: false
      t.string :document_type, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end
