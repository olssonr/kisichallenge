ActiveSupport::Notifications.subscribe "enqueue.active_job" do |*args|
  event = ActiveSupport::Notifications::Event.new *args
  Rails.logger.info "Job: #{event.payload[:job]} enqueued!"
end

ActiveSupport::Notifications.subscribe "perform.active_job" do |*args|
  event = ActiveSupport::Notifications::Event.new *args
  Rails.logger.info "Job: #{event.payload[:job]} performed!"

  begin
    metric = Metric.find_or_initialize_by(name: 'jobs_performed_total_count')
    metric.value += 1
    metric.save!
    Rails.logger.info "Saved: #{metric}"
  rescue Exception => e
    Rails.logger.info "Got exception: #{e.inspect}"
  end
end