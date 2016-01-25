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
  
  def edit
    @event = Event.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @event = Event.find(params[:id])
    success = @event.update_attributes(event_params) if @event
    flash[:error] = 'Update failed' unless success
    redirect_to admin_events_path    
  end

  def create
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        format.js
        format.html { redirect_to admin_events_path }
      else
        format.json { render json: @event.errors.full_messages,
                                     status: :unprocessable_entity }
        format.html do
          flash[:error] = "Create event failed"
          redirect_to admin_events_path
        end 
             
      end
    end
  end

  def destroy
    event = Event.find(params[:id])    
    event.destroy if event
    respond_to do |format|
      format.js
    end
  end

  private
  def event_params
    params.require(:event).permit(:name, :time, :address, :image, :member_only, :non_member_fee, :description)
  end
end