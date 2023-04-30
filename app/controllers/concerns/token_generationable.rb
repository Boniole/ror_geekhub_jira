module TokenGenerationable
  extend ActiveSupport::Concern

  DATE_FORMAT = '%m-%d-%Y %H:%M'.freeze

  def generate_token(user_id)
    token = JsonWebToken.encode(user_id: user_id)
    time = Time.now + 24.hours.to_i
    { token: token, expiration_date: time.strftime(DATE_FORMAT) }
  end
end