class Competition < ActiveRecord::Base
  has_many :games, -> { order 'is_finished, created_at DESC' }
  has_many :teams, -> { order 'total_score DESC, name' }
  


end