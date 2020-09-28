require "google/cloud/pubsub"

module ActiveJob
  module QueueAdapters
    class PubSubAdapter
      def initialize
        @project = 'handy-operation-290414'
        @topic_name = 'events'

        @pubsub = Google::Cloud::Pubsub.new project: @project
        @topic = @pubsub.topic  @topic_name
      end

      def enqueue(job)
        @topic.publish ActiveSupport::JSON.encode(job.serialize)
      end

      def enqueue_at(*)
        raise NotImplementedError, "Not implemented yet, perhaps not needed?"
      end
    end
  end
end