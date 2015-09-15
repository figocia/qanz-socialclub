class GamesController < ApplicationController 
  before_action :require_user
  
  def index
    @competitions = Competition.order('is_finished, created_at DESC').all
  end

  def my_games
    @competitions = Competition.where(is_finished: false).order('created_at DESC')
  end

  def edit
    @game = Game.find(params[:id])
  end
  
  def update    
    @game = Game.find(params[:id])

    respond_to do |format|
      if update_scores(@game, game_params)        
        format.json { head :no_content }
        format.js 
        format.html { redirect_to my_games_path }           
      else      
        format.json { render json: @game.errors.full_messages,
                                     status: :unprocessable_entity }
      
        format.html do
          flash[:error] = 'You are not allowed to do that.'
          redirect_to my_games_path
        end      
      end
     
    end
    
  end

  private

  def update_scores(game, game_params)
    # require 'pry'; binding.pry
    if game.include_member?(current_user)
      game.update_attributes(game_params)
    end
    
  end


  def game_params
    params.require(:game).permit(:team_one_score, :team_two_score)
  end
  
end