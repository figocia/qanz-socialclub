require 'rails_helper'

describe Admin::RoundsController do
  before { login_admin }
  let(:competition) { Fabricate(:competition)}
  
  describe 'GET Index' do
    it_behaves_like 'require_admin' do
      let(:action) { get :index, competition_id: competition.id }
    end

    it 'assigns the correct rounds attribute' do
      get :index, competition_id: competition.id
      expect(assigns(:rounds)).to eq(competition.rounds)
    end
  end

  describe 'GET Show' do
    let(:round) { Fabricate(:round, competition: competition )}
    
    it_behaves_like 'require_admin' do
      let(:action) { get :show, competition_id: competition.id, id: round.id }
    end    

    it 'has the right attribute assigned' do
      get :show, competition_id: competition.id, id: round.id 
      expect(assigns(:round)).to eq(round)
    end

  end


  describe 'GET New' do
    it_behaves_like 'require_admin' do
      let(:action) { xhr :get, :new, competition_id: competition.id}
    end        

    it 'assigns the right competition attribute' do
      xhr :get, :new, competition_id: competition.id
      expect(assigns(:competition)).to eq(competition)
    end
  end

  describe 'POST Create' do
    it_behaves_like 'require_admin' do
      let(:action) { xhr :post, :create, competition_id: competition.id, round: { name: 'RoundABC'}}      
    end        

    it 'creates the round successfully' do
      xhr :post, :create, competition_id: competition.id, round: { name: 'RoundABC'}
      expect(Round.first.name).to eq('RoundABC')
    end

    it 'does not create round with duplicated name' do
      roundABC = Fabricate(:round, name: 'RoundABC', competition: competition)
      xhr :post, :create, competition_id: competition.id, round: { name: 'RoundABC'}
      expect(Round.all.size).to eq(1)
    end
  end

  describe 'POST AutoCreateGames' do
    let!(:team1) { Fabricate(:team, name: 'team1', competition: competition)}
    let!(:team2) { Fabricate(:team, name: 'team2', competition: competition)}
    let!(:team3) { Fabricate(:team, name: 'team3', competition: competition)}
    let!(:team4) { Fabricate(:team, name: 'team4', competition: competition)}    
    let(:round2) { Fabricate(:round, competition: competition)}
    
    it_behaves_like 'require_admin' do
      let(:action) { xhr :post, :auto_create_games, round_id: round2.id }      
    end

    it 'creates the next round game automatically base on previous rounds match up' do
      round = Fabricate(:round, competition: competition)
      game = Fabricate(:game, round: round, team_one: team1, team_two: team2, created_at: 2.day.ago)
      game2 = Fabricate(:game, round: round, team_one: team3, team_two: team4, created_at: 1.day.ago)
    
      xhr :post, :auto_create_games, round_id: round2.id 
      expect(round2.reload.games.map(&:team_one)).to eq([team3, team2])
    end

    it 'creates the next round game without previous round' do
      xhr :post, :auto_create_games, round_id: round2.id 
      expect(round2.reload.games.map(&:team_one)).to eq([team1, team2])
    end
  end

  describe 'DELETE Destroy' do
    let!(:round) { Fabricate(:round, competition: competition)}
    
    it_behaves_like 'require_admin' do
      let(:action) { xhr :delete, :destroy, id: round.id, competition_id: competition.id }      
    end        

    it 'deletes the record' do
      xhr :delete, :destroy, id: round.id, competition_id: competition.id
      expect(Round.all.size).to eq(0)
    end
  end
end