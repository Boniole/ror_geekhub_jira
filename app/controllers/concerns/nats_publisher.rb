require 'nats/client'
require 'json'

# TODO module to publich data NATS Serhii
module NatsPublisher #extend ActiveSupport::Concern
  def nats_publish(subject, data)
    nats = NATS.connect(ENV['NATS_SERVER_PORT'])
    nats.publish(subject, data)
  end
end
