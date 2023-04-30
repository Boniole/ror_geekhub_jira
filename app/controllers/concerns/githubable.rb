module Githubable
  extend ActiveSupport::Concern
  include GithubBranchable
  include GithubRepositoryable
  include GithubCommitable

  def github_client
    Octokit::Client.new(access_token: current_user.github_token, auto_paginate: true)
  rescue Octokit::BadRequest
    render_error(errors: 'Github token invalid or empty!', status: :not_found)
  end
end
