require 'rails_helper'

describe JoinSocialClubController do
  
  before { login_current_user }

  after { ActionMailer::Base.deliveries.clear } 

  describe 'POST create' do
    let(:golden_friday) { Fabricate(:event)} 
    let(:eoy) { Fabricate(:event)} 

    it 'sends out the email'

    it 'redirect to the email confirmation page'

    it 'sets the membership_token'
    it 'creates the new event participants'

    context 'not signed in' do
      it_behaves_like 'require_sign_in' do
        let(:action) { post :create, event_id: golden_friday.id }
      end
    end
  end
  
end