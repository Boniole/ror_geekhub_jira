class AddColumnsAndReferenceToDocumnent < ActiveRecord::Migration[7.0]
  def up
    add_column :documents, :name, :string, null: false
    add_column :documents, :document_type, :string, null: false
    add_column :documents, :url, :string, null: false


    add_reference :documents, :user, foreign_key: true
  end

  def down
    remove_reference :documents, :user, foreign_key: true

    remove_column :documents, :name
    remove_column :documents, :document_type
    remove_column :documents, :url
  end
end
