require 'rails_helper'

describe TeamMember do
  it { should belong_to(:member) }
  it { should belong_to(:team) }
end