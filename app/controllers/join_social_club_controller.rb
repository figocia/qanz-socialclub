class JoinSocialClubController < ApplicationController 
  before_action :require_user
  def create
    if current_user.is_member?
      flash[:notice] = 'You are already a member'
      redirect_to home_path
    else      
      if params[:event_id].present?
        event_participant = EventParticipant.new(participant_id: current_user.id, event_id: params[:event_id])
        if event_participant.save
          current_user.generate_membership_token
          AppMailer.delay.join_social_club(current_user, event_participant.event)
        else
          flash[:notice] = "Event already in your list"
        end        
        redirect_to my_events_path
      else
        current_user.generate_membership_token
        AppMailer.delay.join_social_club(current_user)
        redirect_to home_path
      end
    end
  end  
end