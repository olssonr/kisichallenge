ActiveSupport::Notifications.subscribe "enqueue.active_job" do |*args|
  event = ActiveSupport::Notifications::Event.new *args
  Rails.logger.info "Job: #{event.payload[:job]} enqueued!"
end

ActiveSupport::Notifications.subscribe "perform_start.active_job" do |*args|
  event = ActiveSupport::Notifications::Event.new *args

  event_model = event.payload[:job].arguments[0]
  event_model.status = "Started"
  event_model.save!
end

ActiveSupport::Notifications.subscribe "perform.active_job" do |*args|
  event = ActiveSupport::Notifications::Event.new *args

  # TODO: Need to take into consideration if job failed and not set "Performed"
  event_model = event.payload[:job].arguments[0]
  event_model.status = "Performed"
  event_model.save!

  begin
    perform_count = Metric.find_or_initialize_by(name: 'jobs_performed_total_count')
    perform_count.value += 1
    perform_count.save!

    perform_duration = Metric.find_or_initialize_by(name: 'jobs_performed_total_duration')
    perform_duration.value += event.duration
    perform_duration.save!
  rescue Exception => e
    Rails.logger.info "Got exception when trying to save metric: #{e.inspect}"
  end
end