class EventsController < ApplicationController
  before_action :require_user
  
  def index
    @events = Event.order('time').all
  end
end