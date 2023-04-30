module GithubPullrequestable
  extend ActiveSupport::Concern

  def git_pullrequest
    @pullrequest = github_client.create_pull_request(
      current_project.git_repo,
      params[:base_name],
      params[:head_name],
      params[:title],
      params[:body]
    )
  rescue Octokit::UnprocessableEntity => e
    render_error(errors: e.message)
  end
end
