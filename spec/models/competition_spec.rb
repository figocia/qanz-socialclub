  require 'rails_helper'

describe Competition do
  it{ should have_many(:games).order('is_finished, created_at DESC')}
  it{ should have_many(:teams)}

  describe '#popular_teams' do
    it 'gets the team with the correct sequence' do
       competition = Fabricate(:competition)
      team1 = Fabricate(:team, competition: competition )
      team2 = Fabricate(:team, competition: competition )
      team3 = Fabricate(:team, competition: competition )
      game1 = Fabricate(:game, competition: competition, team_one: team1, team_two: team2, team_one_score: 10, team_two_score: 2)
      game2 = Fabricate(:game, competition: competition, team_one: team1, team_two: team2, team_one_score: 10, team_two_score: 2)
      game2 = Fabricate(:game, competition: competition, team_one: team2, team_two: team3, team_one_score: 2, team_two_score: 10)
      
      expect(competition.popular_teams).to eq([team1, team3, team2])      
    end
  end

end