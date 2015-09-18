require 'rails_helper'

describe Event do
  
  it { should have_many(:event_participants) }


  let(:member) { Fabricate(:member)}
  let(:non_member) { Fabricate(:user)}

  describe '#is_free?' do
    it 'is free if user is a member'
    it 'is free if the event is not member only'
    it 'is not free when event is for member only and user is non_member'

  end
end