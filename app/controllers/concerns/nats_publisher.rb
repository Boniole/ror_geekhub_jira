require 'nats/client'
require 'json'

# module to publich data NATS
module NatsPublisher
  def nats_publish(subject, data)
    nats = NATS.connect(ENV['NATS_SERVER_PORT'])
    nats.publish(subject, data)
  end
end
