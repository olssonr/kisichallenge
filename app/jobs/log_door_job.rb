require 'application_job' # Needed by subscriptions.rb to be able to run without rails boot loader

class LogDoorJob < ApplicationJob
  queue_as :default

  def perform(door, event)
    puts "Door: #{door} was #{event}"
  end
end
