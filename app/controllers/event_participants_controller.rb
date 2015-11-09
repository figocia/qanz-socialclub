class EventParticipantsController < ApplicationController 
  before_action :require_user

  def create

    new_item = EventParticipant.new(participant_id: current_user.id, event_id: params[:event_id])
    if new_item.save  
      AppMailer.comming_to_event(new_item).deliver
      redirect_to my_events_path    
    else
      flash[:notice] = 'Already in your Event list.'
      redirect_to :back     
    end
  end

  def destroy
    item = EventParticipant.find(params[:id])
    unless item.nil? 
      AppMailer.not_comming_to_event(item).deliver
      item.destroy
    end
    respond_to do |format|
      format.html { redirect_to my_events_path}      
    end
  end
end