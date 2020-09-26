module ActiveJob
  module QueueAdapters
    class PubSubAdapter
      def enqueue(job)
        Base.execute(job.serialize)
      end

      def enqueue_at(*)
        raise NotImplementedError, "Not implemented yet, perhaps not needed?"
      end
    end
  end
end