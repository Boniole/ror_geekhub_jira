
module Githubable
  extend ActiveSupport::Concern

  def github_client
    Octokit::Client.new(access_token: current_user.github_token, auto_paginate: true)
  rescue Octokit::BadRequest
    render_error(errors: 'Github token invalid or empty!', status: :not_found)
  end

  def git_create_repo
    @repo = github_client.create_repository(
      params[:name],
      description: params[:description],
      private: params[:private],
      has_issues: params[:has_issues],
      has_downloads: params[:has_downloads]
    )
  rescue Octokit::Error => error
    render_error(errors: "Repository #{error.errors.first[:message]}")
  end

  def git_update_repo
    @repo = github_client.edit_repository(
      current_project.git_repo,
      description: params[:description],
      private: params[:private],
      has_issues: params[:has_issues],
      has_downloads: params[:has_downloads]
    )
  rescue Octokit::InvalidRepository => error
    render_error(errors: error.message)
  end

  def git_find_repo
    @repo = github_client.repository(current_project.git_repo)
  rescue Octokit::InvalidRepository => error
    render_error(errors: error.message)
  end

  def git_create_branch
    @new_branch_name = "heads/#{@task.type_of}/#{@task.tag_name}/#{params[:branch_name]}"

    github_client.create_ref(
      current_project.git_repo,
      @new_branch_name,
      params[:sha]
    )
  rescue Octokit::UnprocessableEntity => error
    render_error(errors: error.message)
  end
end
