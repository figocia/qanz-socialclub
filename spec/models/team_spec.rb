require 'rails_helper'

describe Team do
  it { should have_many(:members)}
  it { should have_many(:games)}
  it{ should belong_to(:competition)}
end