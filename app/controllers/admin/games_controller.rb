class Admin::GamesController < AdminsController
  before_action :find_round, only: [:new, :create]
  
  def new
    @game = Game.new
  end

  def create
    
  end

  private
  def find_round
    @round = Round.find(params[:round_id])
  end
end