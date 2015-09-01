class GamesController < ApplicationController 
  before_action :require_user
  
  def index
    @competitions = Competition.order('is_finished, created_at DESC').all
  end
end