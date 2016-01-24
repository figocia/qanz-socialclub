class Admin::EventsController < AdminsController
  def index
    @events = Event.order('time').all
  end

  def new
    @event = Event.new
    respond_to do |format|
      format.js
    end
  end
  
  private
  def event_params
    params.require(:event).permit(:name, :time, :address, :image, :member_only, :non_member_fee, :description)
  end
end