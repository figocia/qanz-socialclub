require 'rails_helper'

describe Admin::RoundsController do
  before { login_admin }
  let(:competition) { Fabricate(:competition)}
  describe 'GET Index' do
    it_behaves_like 'require_admin' do
      let(:action) { get :index, competition_id: competition.id }
    end

    it 'assigns the correct rounds attribute' do
      get :index, competition_id: competition.id
      expect(assigns(:rounds)).to eq(competition.rounds)
    end
  end
end