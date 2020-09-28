require "google/cloud/pubsub"
require 'active_job'
require 'json'
require 'active_support'

lib = File.expand_path('app/jobs', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'log_door_job'

project_id = "handy-operation-290414"
topic_name = "my-topic2"
subscription_name = "my-sub2"

pubsub = Google::Cloud::Pubsub.new project: project_id

subscription = pubsub.subscription subscription_name
subscriber   = subscription.listen do |received_message|
  puts "Received message: #{received_message.data}"
  begin
    ActiveJob::Base.execute ActiveSupport::JSON.decode(received_message.data)
  rescue Exception => e
    puts "Exception: #{e.inspect}"
  end
  received_message.acknowledge!
  puts "Acknowledged message"
end

subscriber.start

sleep 60
subscriber.stop.wait!
