module TwilioSmsable
  extend ActiveSupport::Concern

  included do
    def send_twilio_sms(to_number, message_body)
      account_sid = ENV['TWILIO_ACCOUNT_SID']
      auth_token = ENV['TWILIO_AUTH_TOKEN']
      twilio_number = '+1314388294249'

      client = Twilio::REST::Client.new(account_sid, auth_token)

      client.messages.create(
        to: to_number,
        from: twilio_number,
        body: message_body
      )
    rescue Twilio::REST::TwilioError => e
      puts "Error: #{e.message}"
    end
  end
end
