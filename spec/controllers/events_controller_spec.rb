require 'rails_helper'

describe EventsController do
  before { login_current_user }
  
  describe 'GET Index' do
    let!(:party) { Fabricate(:event, time: 1.day.from_now) }
    let!(:friday_lunch) { Fabricate(:event, time: 3.day.from_now) }
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
    let(:party) { Fabricate(:event, time: 1.day.from_now) }
    let(:friday_lunch) { Fabricate(:event, time: 3.day.from_now) }

    it 'sets the correct instance attribute' do
      get :show, id: party.id
      expect(assigns(:event)).to eq(party)
    end

    

  end

end