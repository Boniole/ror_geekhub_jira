class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :body
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
