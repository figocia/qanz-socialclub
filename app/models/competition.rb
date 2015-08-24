class Competition < ActiveRecord::Base
  has_many :games
  has_many :teams  
end