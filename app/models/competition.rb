class Competition < ActiveRecord::Base
  has_many :games, -> { order 'is_finished, created_at DESC' }
  has_many :teams
  
  def popular_teams
    teams.sort_by{|team| [ -team.total_score, team.name]}
  end

  def games_for_member(user=nil)
    games.select{|game| game.include_member?(user)}
  end
end