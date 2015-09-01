require 'rails_helper'

describe TeamsController do
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
        let(:action){ get :index }
      end
    end
      
  end

end