class AddFieldGitNameToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :git_name, :string
  end
end
