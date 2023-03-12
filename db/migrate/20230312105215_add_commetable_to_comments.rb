class AddCommetableToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :commetable, polymorphic: true, null: false
  end
end
