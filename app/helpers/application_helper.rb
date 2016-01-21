module ApplicationHelper
  def options_for_teams(selected=nil, competition)
    options_for_select(competition.teams.map{|team| [team.name, team.id]}, selected )
  end
end
