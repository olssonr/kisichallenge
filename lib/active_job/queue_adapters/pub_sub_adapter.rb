require "google/cloud/pubsub"
require 'rufus-scheduler'

module ActiveJob
  module QueueAdapters
    class PubSubAdapter
      def initialize
        @project = 'handy-operation-290414'
        @topic_name = 'events'
        @morgue_topic_name = 'events_morgue'

        @pubsub = Google::Cloud::Pubsub.new project: @project
        @topic = @pubsub.topic  @topic_name
        @morgue_topic = @pubsub.topic  @morgue_topic_name
      end

      def enqueue(job)
        publish_job(job)
      end

      def enqueue_at(job, timestamp)
        Rufus::Scheduler.singleton.at Time.at(timestamp) do
          publish_job(job)
        end
      end

      def publish_job(job)
        if job.executions < 3
          @topic.publish ActiveSupport::JSON.encode(job.serialize)
        else
          @morgue_topic.publish ActiveSupport::JSON.encode(job.serialize)
        end
      end

    end
  end
end