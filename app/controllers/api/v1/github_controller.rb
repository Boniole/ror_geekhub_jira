class Api::V1::GithubController < ApplicationController
  before_action :set_user, only: %i[show]

  def show
    github_token = @user.github_token
    client = Octokit::Client.new(access_token: github_token)

    render json: client, status: :ok
  end
  # def login
  #   @user = User.find_by_email(params[:email])
  #   if @user&.authenticate(params[:password])
  #     token = JsonWebToken.encode(user_id: @user.id)
  #     time = Time.now + 24.hours.to_i
  #     render json: { token:, exp: time.strftime('%m-%d-%Y %H:%M'),
  #                    name: @user }, status: :ok
  #   else
  #     render json: { error: 'unauthorized' }, status: :unauthorized
  #   end
  # end

  private
  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end
end
