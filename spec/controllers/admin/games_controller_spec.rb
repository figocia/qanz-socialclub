require 'rails_helper'

describe Admin::GamesController do
  before { login_admin }
  let(:competition) { Fabricate(:competition)}
  let(:round) { Fabricate(:round, competition: competition)}

  describe 'GET New' do
    it_behaves_like 'require_admin' do
      let(:action) { xhr :get, :new}
    end        

    it 'assigns the right round attribute' do
      xhr :get, :new, round_id: round.id
      expect(assigns(:round)).to eq(round)
    end
  end

  describe 'POST Create' do
    let(:teamA) {Fabricate(:team, competition: competition)}
    let(:teamB) {Fabricate(:team, competition: competition)}

    it_behaves_like 'require_admin' do
      let(:action) { xhr :post, :create}
    end

    context 'valid create' do
      it 'creates the game successfully with right team' do
        xhr :post, :create, game: {team_one_id: teamA.id, team_two_id: teamB.id, competition_id: competition.id, round_id: round.id}
        expect(Game.first.team_two).to eq(teamB)
      end

      it 'creates the game with right association to competition' do
        xhr :post, :create, game: {team_one_id: teamA.id, team_two_id: teamB.id, competition_id:  competition.id, round_id: round.id}
        expect(Game.first.competition).to eq(competition)
      end

      it 'creates the game with right association to round' do
        xhr :post, :create, game: {team_one_id: teamA.id, team_two_id: teamB.id, competition_id:  competition.id, round_id: round.id}
        expect(Game.first.round).to eq(round)
      end
    end

    context 'invalid create with same team selected' do
      it 'does not create the game with same teams selected for both side' do
        xhr :post, :create, game: {team_one_id: teamB.id, team_two_id: teamB.id, competition_id:  competition.id, round_id: round.id}
        expect(Game.all.size).to eq(0)
      end
    end
    
  end

  describe 'DELETE Destroy' do
    
    let!(:team1) { Fabricate(:team, name: 'team1', competition: competition)}
    let!(:team2) { Fabricate(:team, name: 'team2', competition: competition)}
    
    let!(:game) { Fabricate(:game, round: round, team_one: team1, team_two: team2, created_at: 2.day.ago)}
    
    
    it_behaves_like 'require_admin' do
      let(:action) { xhr :delete, :destroy, id: game.id}      
    end        

    it 'deletes the record' do
      xhr :delete, :destroy, id: game.id
      expect(Game.all.size).to eq(0)
    end
  end

end