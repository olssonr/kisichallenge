require "google/cloud/pubsub"
require 'active_job'
require 'json'
require 'active_support'

lib = File.expand_path('app/jobs', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'log_door_job'

project_id = "handy-operation-290414"
topic_name = "events"
subscription_name = "events"

pubsub = Google::Cloud::Pubsub.new project: project_id

subscription = pubsub.subscription subscription_name
subscriber   = subscription.listen do |received_message|
  # TODO: pub/sub had min 5 delivery attemps
  # perhaps can use message.delivery_attempt to nack messages after 3 attempts?
  puts "Received message at attempt: #{received_message.delivery_attempt}"
  begin
    ActiveJob::Base.execute ActiveSupport::JSON.decode(received_message.data)
    received_message.acknowledge!
    puts "Acknowledged message"
  rescue Exception => e
    puts "Got Exception, rejects message so will be rerun"
    received_message.reject!
  end
end

subscriber.start

sleep 600
subscriber.stop.wait!
