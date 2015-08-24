class Team < ActiveRecord::Base
  belongs_to :competition
  has_many :team_members
  has_many :members, through: :team_members, source: :user
  has_many :games
end