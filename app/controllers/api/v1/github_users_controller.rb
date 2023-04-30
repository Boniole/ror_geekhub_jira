class Api::V1::GithubUsersController < ApplicationController
  include Githubable

  def show
    user = github_client.user
    render_success(data: Api::V1::GithubUserSerializer.new(user).as_json, status: :ok)
  end
end
