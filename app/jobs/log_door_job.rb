class LogDoorJob < ApplicationJob
  queue_as :default

  def perform(door, event)
    puts "performing the job"
    puts "Door: #{door} was #{event}"
  end
end
