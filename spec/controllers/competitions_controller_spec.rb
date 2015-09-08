require 'rails_helper'

describe CompetitionsController do
  
  describe 'GET Show' do
    context 'sign in' do
      before { login_current_user }
      let(:competition_finished){ Fabricate(:competition, is_finished: true)}    
      let(:competition_ongoing ){ Fabricate(:competition)}    
      let(:competition_ongoing2 ){ Fabricate(:competition, created_at: 1.day.ago)}

      it 'assigns the the competition attribute correctly' do
        get :show, id: competition_ongoing.id
        expect(assigns(:competition)).to eq(competition_ongoing)
      end

    end

    context 'not sign in' do
      it_behaves_like 'require_sign_in' do
        let(:action) { get :show, id: 1}        
      end
    end
    
  end
end