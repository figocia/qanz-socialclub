class Admin::GamesController < AdminsController
  before_action :find_round, only: [:new]
  
  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    respond_to do |format|
      
      if game_params[:team_one_id] != game_params[:team_two_id] && @game.save
        format.js
      else
        format.json { render json: ["It has to be two different teams."],
                                     status: :unprocessable_entity }
      end
    end
  end

  def destroy    
    game = Game.find(params[:id])
    @round = game.round if game
    game.destroy if game
    respond_to do |format|
      format.js
    end
  end

  private
  def find_round
    @round = Round.find(params[:round_id])
  end

  def game_params
    params.require(:game).permit(:team_one_id, :team_two_id, :competition_id, :round_id)
  end
end