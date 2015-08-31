class Team < ActiveRecord::Base
  belongs_to :competition
  has_many :team_members
  has_many :members, through: :team_members
  has_many :games, foreign_key: 'team_one_id'
  has_many :inverse_games, class_name: 'Game', foreign_key: 'team_two_id'  

  def total_score
    games.map(&:team_one_score).inject(:+) + inverse_games.map(&:team_two_score).inject(:+)
  end
end