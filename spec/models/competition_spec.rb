require 'rails_helper'

describe Competition do
  it{ should have_many(:games)}
  it{ should have_many(:teams)}
end