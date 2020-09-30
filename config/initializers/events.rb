ActiveSupport::Notifications.subscribe "enqueue.active_job" do |*args|
  event = ActiveSupport::Notifications::Event.new *args
  Rails.logger.info "Job: #{event.payload[:job]} enqueued!"
end

ActiveSupport::Notifications.subscribe "perform.active_job" do |*args|
  event = ActiveSupport::Notifications::Event.new *args
  Rails.logger.info "Job: #{event.payload[:job]} performed!"

  begin
    perform_count = Metric.find_or_initialize_by(name: 'jobs_performed_total_count')
    perform_count.value += 1
    perform_count.save!
    Rails.logger.info "Saved: #{perform_count}"

    perform_duration = Metric.find_or_initialize_by(name: 'jobs_performed_total_duration')
    perform_duration.value += event.duration
    perform_duration.save!
    Rails.logger.info "Saved: #{perform_duration}"
  rescue Exception => e
    Rails.logger.info "Got exception: #{e.inspect}"
  end
end