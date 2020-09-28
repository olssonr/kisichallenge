class EventController < ApplicationController
  def index
  end

  def create
    puts "Queue Job with #{params[:event]}"
    LogDoorJob.perform_later("Door 1", params[:event])
  end
end
