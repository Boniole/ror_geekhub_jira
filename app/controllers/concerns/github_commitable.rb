module GithubCommitable
  extend ActiveSupport::Concern

  def git_branch_commits
    commits = github_client.commits(current_project.git_repo, sha: params[:sha])
    commits.map { |commit| { commit: commit['commit']['message'] } }
  rescue Octokit::UnprocessableEntity => e
    render_error(errors: e.message)
  end
end
