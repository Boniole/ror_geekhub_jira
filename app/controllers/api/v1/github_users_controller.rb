class Api::V1::GithubUsersController < ApplicationController
  before_action :authorize_github

  def show
    #consorn @github_client. > method gthub user
    user = github_client.user
#serializer 
    render json: { username: user.login, name: user.name, avatar: user.avatar_url, url: user.url }, status: :ok
  end
end
