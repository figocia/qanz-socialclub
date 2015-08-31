class Team < ActiveRecord::Base
  belongs_to :competition
  has_many :team_members
  has_many :members, through: :team_members
  has_many :games, foreign_key: 'team_one_id'
  has_many :inverse_games, class_name: 'Game', foreign_key: 'team_two_id'  

  
  def total_score
    home_scores = games.map(&:team_one_score)
    away_scores = inverse_games.map(&:team_two_score)

    home_score = home_scores.size > 0 ? home_scores.inject(:+) : 0
    away_score = away_scores.size > 0 ? away_scores.inject(:+) : 0

    home_score + away_score
    
  end
end