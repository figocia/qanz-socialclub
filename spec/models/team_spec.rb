require 'rails_helper'

describe Team do
  it { should have_many(:members).through(:team_members)}
  it { should have_many(:games)}
  it { should belong_to(:competition)}

  let!(:competition) { Fabricate(:competition) }
  let!(:team1) { Fabricate(:team, competition: competition ) }
  let!(:team2) { Fabricate(:team, competition: competition ) }
  let!(:team3) { Fabricate(:team, competition: competition ) }
  let!(:game1) { Fabricate(:game, competition: competition, team_one: team1, team_two: team2, team_one_score: 10, team_two_score: 2) }
  let!(:game2) { Fabricate(:game, competition: competition, team_one: team1, team_two: team2, team_one_score: 10, team_two_score: 2) }
  let!(:game3) { Fabricate(:game, competition: competition, team_one: team3, team_two: team1, team_one_score: 30, team_two_score: 10) }
  
  describe '#is_first' do
    it 'return true when team rank first in the competition' do
      expect(team1.is_first).to be true
    end

    it 'return true for the second team with the same score' do
      expect(team3.is_first).to be true
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


  describe '#include_member' do
    let(:alice) {  Fabricate(:user) }
    let(:tony ) { Fabricate(:user) }
    let!(:team_member) { Fabricate(:team_member, team: team1, member: alice) }
    it 'returns true if member is a team member' do      
      
      expect(team1.include_member(alice)).to be true
    end

    it 'returns false if member is not a team member' do      
      
      expect(team1.include_member(tony)).not_to be true
    end
  end
end