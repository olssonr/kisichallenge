require 'application_job' # Needed by subscriptions.rb to be able to run without rails boot loader

class LogDoorJob < ApplicationJob
  queue_as :default

  # TODO: use 10 seconds for testing, change to 5 minutes for final test and delivery
  retry_on RuntimeError, wait: 5.minutes, attempts: 4

  def perform(event)
    sleep 1
    raise "Just want to test retries and morgue" if rand(1...100) > 25
    puts "#{event.id}: #{event.message}"
  end
end
