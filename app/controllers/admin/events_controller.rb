class Admin::EventsController < AdminsController
  def index
    @events = Event.order('time').all
  end

  def new
    @event = Event.new    
  end
end