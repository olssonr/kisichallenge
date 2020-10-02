require "google/cloud/pubsub"

class EventController < ApplicationController
  # TODO: We don't refresh the page after creating the event
  # we could either load the page or use ajax for this
  def index
    @events = Event.all
  end

  # TODO: It would make sense to add door as a field for the event, then we could
  # list all events per door for example
  def create
    puts "Queue Job with #{params[:event]}"
    LogDoorJob.perform_later("Door 1", params[:event])
    event = Event.new(message: "Door 1#{params[:event]}", status: "Enqueued")
    event.save!
  end
end
