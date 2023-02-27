class CreateDescs < ActiveRecord::Migration[7.0]
  def change
    create_table :descs do |t|
      t.string :name

      t.timestamps
    end
  end
end
