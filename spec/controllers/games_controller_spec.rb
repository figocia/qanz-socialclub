require 'rails_helper'

describe GamesController do
  
  describe 'GET Index' do
    context 'signed in' do
      before { login_current_user }
      let(:competition_finished){ Fabricate(:competition, is_finished: true)}    
      let(:competition_ongoing ){ Fabricate(:competition)}    
      let(:competition_ongoing2 ){ Fabricate(:competition, created_at: 1.day.ago)}    

      it 'sets the correct @competitions attribute ordered by finished and timestamps' do
         get :index
         expect(assigns(:competitions)).to eq([competition_ongoing, competition_ongoing2, competition_finished])
      end
    end
    
    context 'not signed in' do
      it_behaves_like 'require_sign_in' do
        let(:action) { get :index }
      end
    end
  end

  describe 'GET MyGame' do
    context 'signed in' do
      before { login_current_user }
      before { login_current_user }
      let!(:competition_finished){ Fabricate(:competition, is_finished: true)}    
      let!(:competition_ongoing ){ Fabricate(:competition)}    
      let!(:competition_ongoing2 ){ Fabricate(:competition, created_at: 1.day.ago)}    

      it 'sets the correct @competitions attribute ordered by finished and timestamps' do
         get :my_games
         expect(assigns(:competitions)).to eq([competition_ongoing, competition_ongoing2])
      end
    end

    context 'not signed in' do
      it_behaves_like 'require_sign_in' do
        let(:action) { get :my_games }
      end
    end    
  end

  describe 'PATCH Update' do

    let(:game) { Fabricate(:game)}
    let(:alice) { Fabricate(:user)}
    let(:jason) { Fabricate(:user)}
    let(:tony) { Fabricate(:user)}
    let(:member1) { Fabricate(:team_member, team: game.team_one, member: alice)}
    let(:member1) { Fabricate(:team_member, team: game.team_two, member: tony)}

    before { login(alice) }
    
    context 'not sign in' do
      it_behaves_like 'require_sign_in' do
        let(:action) { patch :update, id: game.id}
      end
    end

    context 'with valid input' do
      it 'updates the games correctly' do
        patch :update, game:{team_one_score: 10, team_two_score: 2}, id: game.id
        expect([game.team_one_score, game.team_two_score]).to eq([10, 2 ])
      end
        
    end

    context 'with invalid input' do
      it 'does not update the game when number is negative' do
        patch :update, game:{team_one_score: -1, team_two_score: 2}, id: game.id
        expect([game.team_one_score, game.team_two_score]).to eq([0, 0 ])  
      end

      it 'does not update the game when decimal provided' do
        patch :update, game:{team_one_score: 10.1, team_two_score: 2}, id: game.id
        expect([game.team_one_score, game.team_two_score]).to eq([0, 0 ])  
      end      
    end

    context 'non teammember updating' do
      before { login(jason) }
      it 'redirect to my games path' do
        patch :update, game:{team_one_score: 10, team_two_score: 2}, id: game.id
        expect(response).to redirect_to my_games_path
      end
      
      it 'does not update the game' do
        patch :update, game:{team_one_score: 10, team_two_score: 2}, id: game.id
        expect([game.team_one_score, game.team_two_score]).to eq([0, 0 ])  
      end
    end
  end
end