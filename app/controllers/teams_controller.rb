class TeamsController < ApplicationController 
  def index
     @competitions = Competition.order('is_finished, created_at DESC').all
  end
end