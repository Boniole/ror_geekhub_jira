
module Githubable
  extend ActiveSupport::Concern

  def github_client
    Octokit::Client.new(access_token: current_user.github_token, auto_paginate: true)
  rescue Octokit::BadRequest
    render_error(errors: 'Github token invalid or empty!', status: :not_found)
  end

  def project_git_info
    @project.update(git_url: @repo&.clone_url, git_repo: @repo&.full_name)
  end

  def git_create_repo
    @repo = github_client.create_repository(
      params[:name],
      description: params[:description],
      private: params[:private],
      has_issues: params[:has_issues],
      has_downloads: params[:has_downloads]
    )
  end

  def git_update_repo
    @repo = github_client.edit_repository(
      @project.git_repo,
      description: params[:description],
      private: params[:private],
      has_issues: params[:has_issues],
      has_downloads: params[:has_downloads]
    )
  end
end
