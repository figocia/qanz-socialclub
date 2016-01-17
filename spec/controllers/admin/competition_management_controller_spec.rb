require 'rails_helper'

describe Admin::CompetitionManagementController do
  
  before { login_admin}

  describe 'GET Index' do
    let!(:foosballone) { Fabricate(:competition)}
    let!(:foosballtwo) { Fabricate(:competition)}
    
    it 'assigns the right competiton attribute order by created_at desc' do
      get :index
      expect(assigns(:competitions)).to eq([foosballtwo, foosballone])
    end

  end

end