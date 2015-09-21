  require 'rails_helper'

describe EventParticipant do
  
  it { should belong_to(:event) }
  it { should belong_to(:participant) }

end