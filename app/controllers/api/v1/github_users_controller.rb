class Api::V1::GithubUsersController < ApplicationController
  include Githubable

  def show
    render_success(data: Api::V1::GithubUserSerializer.new(github_client.user).as_json, status: :ok)
  end
end
