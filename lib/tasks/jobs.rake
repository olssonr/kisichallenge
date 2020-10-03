namespace :jobs do
  desc "Start Google Pub/Sub Job Subscription"
  task subscribe: :environment do
    require "google/cloud/pubsub"

    project_id = "handy-operation-290414"
    topic_name = "events"
    subscription_name = "events"

    pubsub = Google::Cloud::Pubsub.new project: project_id

    subscription = pubsub.subscription subscription_name
    subscriber   = subscription.listen do |received_message|
      # Ack message directly and let active job layer take it from here
      received_message.acknowledge!

      ActiveJob::Base.execute ActiveSupport::JSON.decode(received_message.data)
    end

    subscriber.start

    sleep 600
    subscriber.stop.wait!
  end

end
