class EventController < ApplicationController
  def index
  end

  def create
    puts "Queue Job with #{params[:event]}"
    LogDoorJob.perform_later("door1", params[:event])
  end
end
