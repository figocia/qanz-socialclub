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

  describe '#games_for_member' do
    it 'returns all games for a user he participate in this competition' do
      competition = Fabricate(:competition)
      alice = Fabricate(:user)
      tony = Fabricate(:user)
      figo = Fabricate(:user)
      alex = Fabricate(:user)
      user1 = Fabricate(:user)
      user2 = Fabricate(:user)
      user3 = Fabricate(:user)
      user4 = Fabricate(:user)
      user5 = Fabricate(:user)
      
      team1 = Fabricate(:team, competition: competition )
      team2 = Fabricate(:team, competition: competition )
      team3 = Fabricate(:team, competition: competition )
      team4 = Fabricate(:team, competition: competition )


      team_member1 = Fabricate(:team_member, team: team1, member: alice)
      team_member2 = Fabricate(:team_member, team: team1, member: figo )

      team_member3 = Fabricate(:team_member, team: team2, member: tony)
      team_member4 = Fabricate(:team_member, team: team2, member: alex )

      team_member5 = Fabricate(:team_member, team: team3, member: user3)
      team_member6 = Fabricate(:team_member, team: team3, member: user4 )

      team_member7 = Fabricate(:team_member, team: team4, member: user1)
      team_member8 = Fabricate(:team_member, team: team4, member: user2 )

      game1 = Fabricate(:game, competition: competition, team_one: team1, team_two: team2, team_one_score: 10, team_two_score: 2, created_at: 1.day.ago)
      game2 = Fabricate(:game, competition: competition, team_one: team2, team_two: team3, team_one_score: 10, team_two_score: 2, created_at: 2.day.ago)
      game3 = Fabricate(:game, competition: competition, team_one: team1, team_two: team4, team_one_score: 2, team_two_score: 10, created_at: 3.day.ago)
      game4 = Fabricate(:game, competition: competition, team_one: team2, team_two: team1, team_one_score: 2, team_two_score: 10, created_at: 4.day.ago)

      expect(competition.games_for_member(figo)).to eq([game1, game3, game4])
    end
  end

end