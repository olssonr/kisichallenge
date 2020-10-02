require 'application_job' # Needed by subscriptions.rb to be able to run without rails boot loader

class LogDoorJob < ApplicationJob
  queue_as :default

  def perform(event)
    sleep 1
    puts "#{event.id}: #{event.message}"
    # Todo here we can fetch the event and update the status
    #raise Exception, "just want to test retries and morgue"
  end
end
