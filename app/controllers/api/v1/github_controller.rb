class Api::V1::GithubController < ApplicationController
  before_action :authorize_request
  before_action :set_client, only: %i[show]

  def show
    user = @client.user

    render json: { username: user.login, name: user.name, avatar: user.avatar_url, url: user.url }, status: :ok
  end

  private

  def set_client
    @client = Octokit::Client.new(access_token: @current_user.github_token, auto_paginate: true)
  end
end
