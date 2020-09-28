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
  puts "Received message at attempt: #{received_message.delivery_attempt}"

  if received_message.delivery_attempt > 3
    received_message.reject!
    puts "Rejecting message cause max 3 attempts are allowed"
    next
  end

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
