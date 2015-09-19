class EventsController < ApplicationController
  before_action :require_user
  
  def index
    @events = Event.order('time').all    
  end

  def show
    @event = Event.find(params[:id])
    @map_hash = Gmaps4rails.build_markers([@event]) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
    end
  end
end