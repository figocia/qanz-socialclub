class EventParticipantsController < ApplicationController 
  before_action :require_user

  def create

    new_item = EventParticipant.new(participant_id: current_user.id, event_id: params[:event_id])
    if new_item.save
      respond_to do |format|
        format.html { redirect_to my_events_path }
      end
    else
      respond_to do |format|
        format.html do
          flash[:notice] = 'Already in your Event list.'
          redirect_to :back   
        end
        
      end
    end
  end

  def destroy
    item = EventParticipant.find(params[:id])
    item.destroy unless item.nil?
    respond_to do |format|
      format.html { redirect_to my_events_path}      
    end
  end
end