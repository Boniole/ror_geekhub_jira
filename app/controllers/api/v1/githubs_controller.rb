class Api::V1::GithubsController < ApplicationController
  before_action :authorize_request
  before_action :set_client, only: %i[show create]
  before_action :github_params, only: %i[create]

  def show
    user = @client.user

    render json: { username: user.login, name: user.name, avatar: user.avatar_url, url: user.url }, status: :ok
  end

  def create
    repo = @client.create_repository(
      params[:name],
      description: params[:description],
      private: params[:private],
      has_issues: params[:has_issues])

    render json: { name: repo.name, description: repo.description, url: repo.html_url }, status: :ok
  end

  private

  def set_client
    @client = Octokit::Client.new(access_token: @current_user.github_token, auto_paginate: true)
  rescue Octokit::BadRequest
    render json: { errors: 'Github token invalid!' }, status: :not_found
  end

  def github_params
    params.require(:github).permit(:name, :description, :private, :has_issues)
  end
end
