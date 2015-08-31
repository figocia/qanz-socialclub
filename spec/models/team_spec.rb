require 'rails_helper'

describe Team do
  it { should have_many(:members).through(:team_members)}
  it { should have_many(:games)}
  it { should belong_to(:competition)}

  let!(:competition) { Fabricate(:competition) }
  let!(:team1) { Fabricate(:team, competition: competition ) }
  let!(:team2) { Fabricate(:team, competition: competition ) }
  let!(:game1) { Fabricate(:game, competition: competition, team_one: team1, team_two: team2, team_one_score: 10, team_two_score: 2) }
  let!(:game2) { Fabricate(:game, competition: competition, team_one: team1, team_two: team2, team_one_score: 10, team_two_score: 2) }
  let!(:game3) { Fabricate(:game, competition: competition, team_one: team2, team_two: team1, team_one_score: 2, team_two_score: 10) }
  
  describe '#is_first' do
    it 'return true when team rank first in the competition' do
      expect(team1.is_first).to be true
    end

    it 'return false when team rank not first' do
      expect(team2.is_first).not_to be true
    end
  end
  describe '#total_score' do
    it 'get the correct total score for the team' do
      


      expect(team1.total_score).to eq(30)
    end
  end

end