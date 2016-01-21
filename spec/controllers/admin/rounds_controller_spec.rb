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
end