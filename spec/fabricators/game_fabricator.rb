Fabricator(:game) do
  competition
  team_one { Fabricate(:team)}
  team_two { Fabricate(:team)}
  team_one_score 0
  team_one_score 0
  round
end

