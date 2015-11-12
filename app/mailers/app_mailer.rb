class AppMailer < ActionMailer::Base 
  
  def update_score_notification(user, game)
    @user = user
    @game = game
    mail from: "#{@user.email}", to: Rails.env.staging? ? 'yufei.chen@3ds.com' : 'yufei.chen@3ds.com', subject: "Game scores update for #{@game.competition.name}"
  end

  def not_comming_to_event(event_participant) 
    @user = event_participant.participant
    @event = event_participant.event
    mail from: "#{@user.email}", to: Rails.env.staging? ? 'yufei.chen@3ds.com' : 'yufei.chen@3ds.com', subject: "#{@user.name} not comming to #{@event.name}"
    
  end

  def comming_to_event(event_participant)
    @user = event_participant.participant
    @event = event_participant.event
    mail from: "#{@user.email}", to: Rails.env.staging? ? 'yufei.chen@3ds.com' : 'yufei.chen@3ds.com', subject: "#{@user.name} is comming to #{@event.name}"
  end

  def join_social_club(user, event_participant=nil)
    @user = user
    @event = event_participant
    mail from: "#{@user.email}", to: Rails.env.staging? ? 'yufei.chen@3ds.com' : 'yufei.chen@3ds.com', subject: event_participant.nil? ? "#{@user.name} is joining social club" : "#{@user.name} is joining socialclub and comming to #{@event.name}"
  end

  def forgot_password(user)
    @user = user
    mail from: 'info@qanz-socialclub.com', to: Rails.env.staging? ? 'info@qanz-socialclub.com' : user.email, subject: 'Resetting your password'
  end
end