require 'application_job' # Needed by subscriptions.rb to be able to run without rails boot loader

class LogDoorJob < ApplicationJob
  queue_as :default

  def perform(door, event)
    puts "#{door} was #{event}"
    raise Exception, "just want to test retries and morgue"
  end
end
