class RemoveDefaultFromStatusInProjects < ActiveRecord::Migration[7.0]
  def change
    change_column_default :projects, :status, from: 0, to: nil
  end
end
