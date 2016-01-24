class Admin::EventsController < AdminsController
  def index
    
  end

  def new
    @event = Event.new    
  end
end