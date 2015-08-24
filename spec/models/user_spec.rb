require 'rails_helper'

describe User do
  it { should have_many(:teams).through(:team_members)}
  
end