require 'rails_helper'

describe EventsController do
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
  describe 'GET Index' do
    let!(:party) { Fabricate(:event, time: 1.day.from_now, address: 'New York, NY') }
    let!(:friday_lunch) { Fabricate(:event, time: 3.day.from_now, address: 'New York, NY') }
    it 'returns the events in order' do
      get :index
      expect(assigns(:events)).to eq([party, friday_lunch])
    end

    context 'not logged in' do
      it_behaves_like 'require_sign_in' do
        let(:action) { get :index }
      end
    end
  end

  describe 'GET Show' do
    let(:party) { Fabricate(:event, time: 1.day.from_now, address: 'New York, NY') }
    let(:friday_lunch) { Fabricate(:event, time: 3.day.from_now, address: 'New York, NY') }

    it 'sets the correct instance attribute' do
      get :show, id: party.id
      expect(assigns(:event)).to eq(party)
    end
  end

  describe 'GET MyEvent' do
    let!(:party) { Fabricate(:event, time: 1.day.from_now, address: 'New York, NY') }
    let!(:friday_lunch) { Fabricate(:event, time: 3.day.from_now, address: 'New York, NY') }
    let!(:eoy) { Fabricate(:event, time: 4.day.from_now, address: 'New York, NY') }
    let!(:participate) { Fabricate(:event_participant, event: friday_lunch, participant: current_user)}
    let!(:participate2) { Fabricate(:event_participant, event: eoy, participant: current_user)}

    it "returns the current_user's comming event" do
      get :my_events
      expect(assigns(:events)).to eq([friday_lunch, eoy])
    end

  end


end