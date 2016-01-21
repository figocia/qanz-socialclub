require 'rails_helper'

describe Admin::GamesController do
  before { login_admin }
  let(:competition) { Fabricate(:competition)}
  let(:round) { Fabricate(:round, competition: competition)}

  describe 'GET New' do
    it_behaves_like 'require_admin' do
      let(:action) { xhr :get, :new}
    end        

    it 'assigns the right round attribute' do
      xhr :get, :new, round_id: round.id
      expect(assigns(:round)).to eq(round)
    end
  end

  

end