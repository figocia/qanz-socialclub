require 'rails_helper'

describe GamesController do
  
  describe 'GET Index' do
    let(:competition_finished){ Fabricate(:competition, is_finished: true)}    
    let(:competition_ongoing ){ Fabricate(:competition)}
    let(:gameA) { Fabricate(:game, competition: competition_finished)}
    let(:gameB) { Fabricate(:game, competition: competition_ongoing)}
    let(:gameC) { Fabricate(:game, competition: competition_ongoing, is_finished: true )}
    let(:gameD) { Fabricate(:game, competition: competition_ongoing )}
    it 'sets the correct @games attribute ordered by finished and timestamps' do
       get :index
       expect(assigns(:games)).to eq([:gameD, :gameB, :gameC])
    end  
  end
end