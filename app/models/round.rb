class Round < ActiveRecord::Base
  belongs_to :competition
  has_many :games

  validates_uniqueness_of :name, scope: :competition_id
end