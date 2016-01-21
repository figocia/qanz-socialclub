class Competition < ActiveRecord::Base
  has_many :rounds, -> { order  'created_at DESC' }, :dependent => :destroy
  has_many :games, -> { order 'is_finished, created_at DESC' }, :dependent => :destroy
  has_many :teams, -> { order 'name' }, :dependent => :destroy

  validates :name, presence: true, uniqueness: true
  
  def popular_teams
    teams.sort_by{|team| [ -team.total_score, team.name]}
  end

  def games_for_member(user=nil)
    games.select{|game| game.include_member?(user)}
  end

  def include_member?(user)
    teams.any?{|team| team.include_member?(user)}
  end

  def unallocated_users
    User.order('name').all.select{|user| !include_member?(user)}
  end

  def next_team_index
    teams.size + 1
  end

  def latest_round_name
    rounds.first.name
  end

  def allocate_users_to_teams_evenly
      
      if unallocated_users.size > 0 && teams.size > 0            
        average_num = User.all.size / teams.size.to_f

        
        unallocated_users.each do |user|

          team = teams.select{|t| t.reload.team_members.size < average_num }.sort_by{|item| item.team_members.size }.first
          
          TeamMember.create(member: user, team: team ) if team

        end
        
      end
  end


end