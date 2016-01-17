class Competition < ActiveRecord::Base
  has_many :games, -> { order 'is_finished, created_at DESC' }
  has_many :teams, -> { order 'name' }

  validates :name, presence: true, uniqueness: true
  
  def popular_teams
    teams.sort_by{|team| [ -team.total_score, team.name]}
  end

  def games_for_member(user=nil)
    games.select{|game| game.include_member?(user)}
  end

  def include_member?(user)
    teams.any?{|team| team.include_member?(user)}
  end

  def unallocated_users
    User.order('name').all.select{|user| !include_member?(user)}
  end
end