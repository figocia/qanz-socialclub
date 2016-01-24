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

  
end