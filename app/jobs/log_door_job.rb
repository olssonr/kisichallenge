class LogDoorJob < ApplicationJob
  queue_as :default

  def perform(door, event)
    puts("Door: #{door} was #{event}")
  end
end
