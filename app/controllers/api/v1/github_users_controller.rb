class Api::V1::GithubUsersController < ApplicationController
  before_action :authorize_request, :authorize_github

  def show
    user = @github_client.user

    render json: { username: user.login, name: user.name, avatar: user.avatar_url, url: user.url }, status: :ok
  end
end
