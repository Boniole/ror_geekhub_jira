class RemoveDefaultFromStatusInComments < ActiveRecord::Migration[7.0]
  def change
    change_column_default :comments, :status, from: 0, to: nil
  end
end
