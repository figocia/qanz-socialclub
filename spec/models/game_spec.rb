require 'rails_helper'

describe Game do   
  it{ should belong_to(:team_one) }
  it{ should belong_to(:team_two) }
  it{ should belong_to(:competition)}
  
end