module GithubBranchable
  extend ActiveSupport::Concern

  def git_create_branch
    @new_branch_name = "heads/#{@task.type_of}/#{@task.tag_name}/#{params[:branch_name]}"

    github_client.create_ref(
      current_project.git_repo,
      @new_branch_name,
      params[:sha]
    )
  rescue Octokit::UnprocessableEntity => e
    render_error(errors: e.message)
  end

  def git_get_brenches
    branches = github_client.branches(current_project.git_repo)
    branches.map { |branch| { name: branch.name, sha: branch.commit.sha } }
  rescue Octokit::UnprocessableEntity => e
    render_error(errors: e.message)
  end

  def git_task_brenches(task_name)
    git_get_brenches.select { |branch| branch[:name].match(%r{/#{Regexp.escape(task_name)}/}) }
  end
end
