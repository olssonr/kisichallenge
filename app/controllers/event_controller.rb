class EventController < ApplicationController
  def index
  end

  def create
    puts "Queue Job"
    puts params[:event]
  end
end
