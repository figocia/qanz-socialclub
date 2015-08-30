require 'rails_helper'

describe TeamsController do
  describe 'GET Index' do
    let(:competition_finished){ Fabricate(:competition, is_finished: true)}    
    let(:competition_ongoing ){ Fabricate(:competition)}    
    let(:competition_ongoing2 ){ Fabricate(:competition, created_at: 1.day.ago)}    
    it 'sets the correct @competitions attribute ordered by finished and timestamps' do
       get :index
       expect(assigns(:competitions)).to eq([competition_ongoing, competition_ongoing2, competition_finished])
    end    
  end
end