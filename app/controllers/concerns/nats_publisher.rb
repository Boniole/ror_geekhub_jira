require 'nats/client'
require 'json'

module NatsPublisher
  extend ActiveSupport::Concern

  private
  def nats_publish(subject, data)
    nats = NATS.connect(ENV['NATS_SERVER_PORT'])
    nats.publish(subject, data)
  end
end
