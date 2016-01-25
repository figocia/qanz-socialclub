require 'rails_helper'

describe Admin::EventsController do
  before { login_admin }

  describe 'GET New' do
    it_behaves_like 'require_admin' do
      let(:action) { xhr :get, :new}
    end        

    it 'assigns the right event attribute' do
      xhr :get, :new
      expect(assigns(:event)).to be_an_instance_of Event
    end
  end

  describe 'GET Index' do
    let!(:party) { Fabricate(:event, time: 1.day.from_now, address: 'New York, NY') }
    let!(:friday_lunch) { Fabricate(:event, time: 3.day.from_now, address: 'New York, NY') }
    
    it_behaves_like 'require_admin' do
      let(:action) { get :index}
    end        

    it 'returns the events in order' do
      get :index
      expect(assigns(:events)).to eq([party, friday_lunch])
    end
  end


  describe 'POST Create' do
    
    it_behaves_like 'require_admin' do
      let(:action) { xhr :post, :create}
    end            

    it 'creates the event' do
      post :create, event: {name: 'Event1'}
      expect(Event.all.size).to eq(1)
    end
  end

  describe 'DELETE Destroy' do
    
    let(:event) { Fabricate(:event)}
    
    
    it_behaves_like 'require_admin' do
      let(:action) { xhr :delete, :destroy, id: event.id}      
    end        

    it 'deletes the record' do
      xhr :delete, :destroy, id: event.id
      expect(Event.all.size).to eq(0)
    end
  end


  describe 'GET Edit' do
    let!(:party) { Fabricate(:event, time: 1.day.from_now, address: 'New York, NY') }

    it_behaves_like 'require_admin' do
      let(:action) { xhr :get, :edit, id: party.id}
    end        

    it 'has the right event assigned' do
      xhr :get, :edit, id: party.id
      expect(assigns(:event)).to eq(party)
    end
  end

  describe 'PATCH Update' do
    let(:party) { Fabricate(:event, time: 1.day.from_now, address: 'New York, NY') }

    it_behaves_like 'require_admin' do
      let(:action) { xhr :patch, :update, event: { name: 'updated event', address: 'New York, NY', time: 1.day.from_now }, id: party.id}
    end        

    it 'updates the event' do
       patch :update, event: { name: 'updated event', address: 'New York, NY', time: 1.day.from_now }, id: party.id
       expect(party.reload.name).to eq('updated event')
    end

  end

end