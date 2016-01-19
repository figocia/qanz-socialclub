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
end