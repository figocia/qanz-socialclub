class AppMailer < ActionMailer::Base 
  
  def update_score_notification(user, game)
    @user = user
    @game = game
    mail from: "#{@user.email}", to: Rails.env.staging? ? 'figocia@hotmail.com' : 'yufei.chen@3ds.com', subject: "Game scores update for #{@game.competition.name}"
  end

  def not_comming_to_event(event_participant) 
    @user = event_participant.participant
    @event = event_participant.event
    mail from: "#{@user.email}", to: Rails.env.staging? ? 'figocia@hotmail.com' : 'yufei.chen@3ds.com', subject: "#{@user.name} not comming to #{@event.name}"
    
  end

  def comming_to_event(event_participant)
    @user = event_participant.participant
    @event = event_participant.event
    mail from: "#{@user.email}", to: Rails.env.staging? ? 'figocia@hotmail.com' : 'yufei.chen@3ds.com', subject: "#{@user.name} is comming to #{@event.name}"
  end

  def join_social_club(user, event_participant=nil)
    @user = user
    @event = event_participant
    mail from: "#{@user.email}", to: Rails.env.staging? ? 'figocia@hotmail.com' : 'yufei.chen@3ds.com', subject: event_participant.nil? ? "#{@user.name} is joining social club" : "#{@user.name} is joining socialclub and comming to #{@event.name}"
  end

  def forgot_password(user)
    @user = user
    mail from: 'info@qanz-socialclub.com', to: Rails.env.staging? ? 'figocia@hotmail.com' : user.email, subject: 'Resetting your password'
  end

  def event_confirmed(event)
    @event = event
    recipients = @event.participants.map(&:email).join(',')
    mail from: 'info@qanz-socialclub.com', to: Rails.env.staging? ? "figocia@hotmail.com" : recipients, subject: "Confirmation of event #{@event.name}" if recipients.size > 0
  end

  def event_unconfirmed(event)
    @event = event
    recipients = @event.participants.map(&:email).join(',')
    mail from: 'info@qanz-socialclub.com', to: Rails.env.staging? ? "figocia@hotmail.com" : recipients, subject: "Cancellation of event #{@event.name}" if recipients.size > 0
  end
end