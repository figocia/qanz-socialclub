require 'rails_helper'

describe Competition do
  it{ should have_many(:games).order('is_finished, created_at DESC')}
  it{ should have_many(:teams)}


end