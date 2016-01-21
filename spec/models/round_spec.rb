require 'rails_helper'

describe Round do   
  it{ should belong_to(:competition) }
  it{ should have_many(:games) }
  it{ should validate_uniqueness_of(:name).scoped_to(:competition_id) }

  
  describe '#previous' do
    it 'returns the correct previous'  do
      competition = Fabricate(:competition)
      round1 = Fabricate(:round, name: 'round1', competition: competition )   
      round2 = Fabricate(:round, name: 'round2', competition: competition )   
      round3 = Fabricate(:round, name: 'round3', competition: competition )   

      expect(round2.previous).to eq(round1)
    end

    it 'return nil for the first one' do
      competition = Fabricate(:competition)
      round1 = Fabricate(:round, competition: competition )   
      expect(round1.previous).to be nil
    end
  end
end