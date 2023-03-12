class CreateColumns < ActiveRecord::Migration[7.0]
  def change
    create_table :columns do |t|
      t.text :name
      t.references :columnntable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
