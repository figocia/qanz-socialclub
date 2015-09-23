require 'rails_helper'

describe EventParticipantsController do 

  before { login_current_user }

  before(:all) do 
  Geocoder.configure(:lookup => :test)

  Geocoder::Lookup::Test.add_stub(
  "New York, NY", [
    {
      'latitude'     => 40.7143528,
      'longitude'    => -74.0059731,
      'address'      => 'New York, NY, USA',
      'state'        => 'New York',
      'state_code'   => 'NY',   
      'country'      => 'United States',
      'country_code' => 'US'
    }
   ]
  )
 end


  describe "POST Create" do
    let(:golden_friday) { Fabricate(:event, address: 'New York, NY')} 
    let(:eoy) { Fabricate(:event, address: 'New York, NY')} 
    
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

    end

    context 'not sign in' do
      it_behaves_like 'require_sign_in' do
        let(:action) { post :create, event_id: golden_friday.id }
      end
    end

  end


  describe 'DELETE Destroy' do 
    let(:golden_friday) { Fabricate(:event, address: 'New York, NY')}     
    let!(:event_participant1) { Fabricate(:event_participant, participant: current_user, event: golden_friday )}
    

    it 'removes the user from the event' do
      
    end




  end
end