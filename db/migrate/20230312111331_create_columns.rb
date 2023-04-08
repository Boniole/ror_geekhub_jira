class CreateColumns < ActiveRecord::Migration[7.0]
  def change
    create_table :columns do |t|
      t.text :name

      t.timestamps
    end
  end
end
