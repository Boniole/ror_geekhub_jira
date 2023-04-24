class Api::V1::GithubUsersController < ApplicationController
  include Githubable

  def show
    user = github_client.user
#serializer 
    render json: { username: user.login, name: user.name, avatar: user.avatar_url, url: user.url }, status: :ok
  end
end
