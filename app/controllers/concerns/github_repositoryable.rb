module GithubRepositoryable
  def git_create_repo
    @repo = github_client.create_repository(
      params[:name],
      description: params[:description],
      private: params[:private],
      has_issues: params[:has_issues],
      has_downloads: params[:has_downloads]
    )
  rescue Octokit::Error => e
    render_error(errors: "Repository #{e.errors.first[:message]}")
  end

  def git_update_repo
    @repo = github_client.edit_repository(
      current_project.git_repo,
      description: params[:description],
      private: params[:private],
      has_issues: params[:has_issues],
      has_downloads: params[:has_downloads]
    )
  rescue Octokit::InvalidRepository => e
    render_error(errors: e.message)
  end

  def git_find_repo
    @repo = github_client.repository(current_project.git_repo)
  rescue Octokit::InvalidRepository => e
    render_error(errors: e.message)
  end
end
