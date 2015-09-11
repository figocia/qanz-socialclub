class Game < ActiveRecord::Base
  belongs_to :team_one, class_name: 'Team'
  belongs_to :team_two, class_name: 'Team'
  belongs_to :competition

  validates_numericality_of :team_one_score, {only_integer: true, greater_than_or_equal_to: 0 }
  validates_numericality_of :team_two_score, {only_integer: true, greater_than_or_equal_to: 0 }  
  
  def include_member?(user)
    team_one.include_member?(user) || team_two.include_member?(user)
  end
end