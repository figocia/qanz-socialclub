require 'rails_helper'

describe Round do   
  it{ should belong_to(:competition) }
  it{ should have_many(:games) }
  it{ should validate_uniqueness_of(:name).scoped_to(:competition_id) }

  
end