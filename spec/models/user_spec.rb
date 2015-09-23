require 'rails_helper'

describe User do
  it { should have_many(:teams).through(:team_members)}
  it { should have_many(:events).through(:event_participants)} 

  describe '#comming_to_event?(event)' do
    let(:alice) {Fabricate(:user)}
    let(:tony) {Fabricate(:user)}
    let(:golden_friday) { Fabricate(:event, address: 'New York, NY')} 
    let(:eoy) { Fabricate(:event, address: 'New York, NY')} 

    it 'return true if user will come to the event' do
      Fabricate(:event_participant, event: golden_friday, participant: alice)
      expect(alice.comming_to_event?(golden_friday)).to be true
    end
    
    it 'return false if user will come to the event' do
      
      expect(alice.comming_to_event?(golden_friday)).to be false
    end
  end

  describe '#event_participant(event)' do
    let(:alice) {Fabricate(:user)}
    let(:tony) {Fabricate(:user)}
    let(:golden_friday) { Fabricate(:event, address: 'New York, NY')} 
    let(:eoy) { Fabricate(:event, address: 'New York, NY')} 

    it 'return the event_participant correctly' do
      event_participant = Fabricate(:event_participant, participant: alice, event: golden_friday )  
      expect(alice.event_participant(golden_friday)).to eq(event_participant)
    end

    it 'return nil if user not going to that event' do
      
      expect(alice.event_participant(golden_friday)).to be nil
    end
  end
end