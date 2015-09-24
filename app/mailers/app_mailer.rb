class AppMailer < ActionMailer::Base 
  def update_score_notification(user, game)
    @user = user
    @game = game
    mail from: "#{@user.email}", to: Rails.env.staging? ? 'yufei.chen@3ds.com' : 'yufei.chen@3ds.com', subject: "Game scores update for #{@game.competition.name}"
  end

  def not_comming_to_event(user, event) 
    @user = user
    @event = event
    mail from: "#{@user.email}", to: Rails.env.staging? ? 'yufei.chen@3ds.com' : 'yufei.chen@3ds.com', subject: "#{@user.name} not comming to #{@event.name}"
    
  end

  def comming_to_event(user, event)
    @user = user
    @event = event
    mail from: "#{@user.email}", to: Rails.env.staging? ? 'yufei.chen@3ds.com' : 'yufei.chen@3ds.com', subject: "#{@user.name} is comming to #{@event.name}"
  end
end