class Game < ActiveRecord::Base
  belongs_to :team_one, class_name: 'Team'
  belongs_to :team_two, class_name: 'Team'
  belongs_to :competition

  def include_member?(user)
    team_one.include_member?(user) || team_two.include_member?(user)
  end
end