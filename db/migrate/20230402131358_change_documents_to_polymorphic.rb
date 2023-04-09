class ChangeDocumentsToPolymorphic < ActiveRecord::Migration[7.0]
  def up
    remove_reference :documents, :project, null: false, foreign_key: true
    remove_reference :documents, :user, null: false, foreign_key: true
    remove_reference :documents, :task, null: true, foreign_key: true
    remove_reference :documents, :comment, null: true, foreign_key: true
    remove_column :documents, :name, :string
    remove_column :documents, :document_type, :string
    remove_column :documents, :url, :string

    add_reference :documents, :documentable, polymorphic: true, null: false
  end

  def down
    remove_reference :documents, :documentable, polymorphic: true, null: false

    add_reference :documents, :project, null: false, foreign_key: true
    add_reference :documents, :user, null: false, foreign_key: true
    add_reference :documents, :task, null: true, foreign_key: true
    add_reference :documents, :comment, null: true, foreign_key: true
    add_column :documents, :name, :string
    add_column :documents, :document_type, :string
    add_column :documents, :url, :string
  end
end
