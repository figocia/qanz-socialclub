class Team < ActiveRecord::Base
  belongs_to :competition
  has_many :team_members
  has_many :members, through: :team_members
  has_many :games, foreign_key: 'team_one_id'
  has_many :inverse_games, foreign_key: 'team_two_id'  
end