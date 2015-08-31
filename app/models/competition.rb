class Competition < ActiveRecord::Base
  has_many :games, -> { order 'is_finished, created_at DESC' }
  has_many :teams
  
  def popular_teams
    teams
  end

end