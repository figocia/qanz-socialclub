require 'rails_helper'

describe Admin::TeamsController do
  before { login_admin }
  let(:competition) { Fabricate(:competition)}
  
  describe 'POST Create' do
    it_behaves_like 'require_admin' do
      let(:action) {  xhr :post, :create, competition_id: competition.id } 
    end

    it 'creates the number of teams required' do
      xhr :post, :create, competition_id: competition.id, count: 3

      expect(competition.teams.size).to eq(3)
    end

    it 'creates the teams with name automatically created with number as suffix' do
      xhr :post, :create, competition_id: competition.id, count: 3

      expect(competition.teams.map(&:name)).to eq(["Team1", "Team2", "Team3"])
    end
  end

  describe 'GET New' do
    it_behaves_like 'require_admin' do
      let(:action) {  xhr :get, :new, competition_id: competition.id } 
    end

    it 'has the competition assign correctly' do
      xhr :get, :new, competition_id: competition.id
      expect(assigns(:competition)).to eq(competition)
    end
  end

  describe 'DELETE Destroy' do
    let(:team) {Fabricate(:team, competition: competition)}
    
    it_behaves_like 'require_admin' do
      let(:action) {   xhr :delete, :destroy, competition_id: competition.id, id: team.id } 
    end    

    it 'deletes the team' do
      xhr :delete, :destroy, competition_id: competition.id, id: team.id 
      expect(Team.all.size).to eq(0)
    end
  end
end