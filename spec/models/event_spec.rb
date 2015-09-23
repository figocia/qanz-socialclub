require 'rails_helper'

describe Event do
  
  it { should have_many(:event_participants) }
  it { should have_many(:participants).through(:event_participants) }

  let(:member) { Fabricate(:member)}
  let(:non_member) { Fabricate(:user)}
  let(:free_event) { Fabricate(:event, member_only: false)}
  let(:member_event) { Fabricate(:event, member_only: true)}
  
  describe '#is_free?' do
    context 'for member only event' do
      it 'return true if user is a member' do        
        expect(member_event.is_free?(member)).to be true
      end

      it 'return false if user is non member' do        
        expect(member_event.is_free?(non_member)).not_to be true
      end
    end
      

    it 'is free if the event is not member only'
    it 'is not free when event is for member only and user is non_member'

  end
end