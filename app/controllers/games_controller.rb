class GamesController < ApplicationController 
  before_action :require_user
  
  def index
    @competitions = Competition.order('is_finished, created_at DESC').all
  end

  def my_games
    @competitions = Competition.where(is_finished: false).order('created_at DESC')
  end
end