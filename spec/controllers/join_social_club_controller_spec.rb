require 'rails_helper'

describe JoinSocialClubController do
  
  before { login_current_user }

  after { ActionMailer::Base.deliveries.clear } 

  describe 'POST create' do
    let(:golden_friday) { Fabricate(:event)} 
    let(:eoy) { Fabricate(:event)} 

    context 'join with going to event' do
      it 'sends out the email' do
        post :create, event_id: golden_friday.id
        expect(ActionMailer::Base.deliveries).not_to eq([])
      end  
      it 'redirect to my event path' do
        post :create, event_id: golden_friday.id
        expect(response).to redirect_to my_events_path
      end
      it 'creates the event_participant successfuly' do
        post :create, event_id: golden_friday.id
        expect(EventParticipant.count).to eq(1)
      end
    end
    
    context 'without going to event' do
      it 'redirect to home path' do
        post :create
        expect(response).to redirect_to home_path
      end

      it 'does not create the event_participant' do
        post :create
        expect(EventParticipant.count).to eq(0)
      end

      it 'sends out email' do
        post :create
        expect(ActionMailer::Base.deliveries).not_to eq([])
      end

      it 'sets the membership_token' do
        post :create
        expect(current_user.membership_token).not_to be nil
      end  
    end

    context 'already is member' do
      let(:member) { Fabricate(:member)}
      before {login(member)}
      it 'does not create the event' do
        post :create, event_id: golden_friday.id
        expect(EventParticipant.count).to eq(0)
      end
      it 'redirect to home_path' do
        post :create
        expect(response).to redirect_to home_path
      end
    end

  
    

    context 'not signed in' do
      it_behaves_like 'require_sign_in' do
        let(:action) { post :create, event_id: golden_friday.id }
      end
    end
  end
  
end