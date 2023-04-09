class AddFieldGitUrlToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :git_url, :string
  end
end
