
# This is just a first test with instrumentation
# TODO: Measuring performed active jobs requires a connection with either the worker or pub/sub so we can now what is actually performed.
ActiveSupport::Notifications.subscribe "enqueue.active_job" do |*args|
    event = ActiveSupport::Notifications::Event.new *args

    Rails.logger.info "Job: #{event.payload[:job]} enqueued!"
end

# There exists a perform event but since there is no connection between subscriber and rails application we do not receive this even
# TODO: Investigate if we want a connection here or if instrumentation should be setup else where and listen to Google pub/sub for example
ActiveSupport::Notifications.subscribe "perform.active_job" do |*args|
    event = ActiveSupport::Notifications::Event.new *args

    Rails.logger.info "Job: #{event.payload[:job]} performed!"
end