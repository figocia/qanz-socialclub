require 'rails_helper'

describe EventParticipantsController do 

  before { login_current_user }
  

  


  describe "POST Create" do
    after { ActionMailer::Base.deliveries.clear }

    let(:golden_friday) { Fabricate(:event)} 
    let(:eoy) { Fabricate(:event)} 
      
    context 'html format' do
       before do
        request.env["HTTP_REFERER"] = "where_i_came_from"
      end
      it 'creates the event_participant successfuly' do
        post :create, event_id: golden_friday.id
        expect(EventParticipant.count).to eq(1)
      end
      it 'redirect_to my events path' do
        post :create, event_id: golden_friday.id
        expect(response).to redirect_to my_events_path
      end

      it 'does not create the event_participant twice' do
        event_participant = Fabricate(:event_participant, participant: current_user, event: golden_friday )
        post :create, event_id: golden_friday.id
        expect(EventParticipant.count).to eq(1)
      end

      it 'redirects back if event already been added to the user' do
        event_participant = Fabricate(:event_participant, participant: current_user, event: golden_friday )
        post :create, event_id: golden_friday.id
        expect(flash[:notice]).to be_present
      end

      it 'sends out the notification email' do
        post :create, event_id: golden_friday.id
        expect(ActionMailer::Base.deliveries).not_to eq([])

      end
    end

    context 'not sign in' do
      it_behaves_like 'require_sign_in' do
        let(:action) { post :create, event_id: golden_friday.id }
      end
    end

  end


  describe 'DELETE Destroy' do 
    let(:golden_friday) { Fabricate(:event)}     
    let!(:event_participant1) { Fabricate(:event_participant, participant: current_user, event: golden_friday )}
    after { ActionMailer::Base.deliveries.clear }

    it 'removes the user from the event' do
      delete :destroy, id: event_participant1.id
      expect(EventParticipant.count).to eq(0)
    end

    it 'sends out email notification' do
      delete :destroy, id: event_participant1.id
      expect(ActionMailer::Base.deliveries).not_to eq([])
    end

    
    it_behaves_like 'require_sign_in' do
      let(:action) { delete :destroy, id: event_participant1.id }
    end


  end
end