class RenameGitNameToGitRepoInProjects < ActiveRecord::Migration[7.0]
  def change
    rename_column :projects, :git_name, :git_repo
  end
end
