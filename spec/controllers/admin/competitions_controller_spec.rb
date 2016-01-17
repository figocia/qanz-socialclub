require 'rails_helper'

describe Admin::CompetitionsController do
  
  before { login_admin}

  describe 'GET Index' do
    let!(:foosballone) { Fabricate(:competition)}
    let!(:foosballtwo) { Fabricate(:competition)}
    
    it 'assigns the right competiton attribute order by created_at desc' do
      get :index
      expect(assigns(:competitions)).to eq([foosballtwo, foosballone])
    end
    it_behaves_like 'require_admin' do
      let(:action) { get :index }      
    end

  end

  describe 'GET New' do
    it 'assigns the right competition attribute' do
      xhr :get, :new
      expect(assigns(:competition)).to be_an_instance_of Competition
    end

    it_behaves_like 'require_admin' do
      let(:action) { xhr :get, :index }      
    end
  end

  describe 'POST Create' do
    it_behaves_like 'require_admin' do
      let(:action) { xhr :post, :create, competition: {name: 'new competition'} }      
    end

    context 'valid input' do
      it 'creates the competition successfully' do
        xhr :post, :create, competition: {name: 'new competition'}
        expect(Competition.first.name).to eq('new competition')
      end
    end

    context 'invalid input' do
      it 'does not create the competition' do
        xhr :post, :create, competition: {name: ''}
        expect(Competition.all.size).to eq(0)
      end
    end
  end

  describe 'GET Show' do
    before { login_admin }
    let(:competition_one) { Fabricate(:competition)}
    let(:teamA) { Fabricate(:team, competition: competition_one )}
    let(:teamB) { Fabricate(:team, competition: competition_one )}
    let!(:gameA) { Fabricate(:game, competition: competition_one, team_one: teamA, team_two:teamB) }
    let!(:gameB) { Fabricate(:game, competition: competition_one, team_one: teamB, team_two:teamA)}
    it_behaves_like 'require_admin' do
      let(:action) { get :show, id: competition_one.id }
    end

    it 'has the right competition attribute assgined' do
      get :show, id: competition_one.id
      expect(assigns(:competition)).to eq(competition_one)
    end


  end
end