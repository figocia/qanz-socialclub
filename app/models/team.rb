class Team < ActiveRecord::Base
  belongs_to :competition
  has_many :members, class_name: 'User'
  has_many :games
end