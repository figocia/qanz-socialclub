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
    @from_admin = params[:from_admin] == 'true'
  end
  
  def update    
    @game = Game.find(params[:id])    
    @from_admin = params[:game][:from_admin] == 'true'
    
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
    if current_user_is_admin? || game.include_member?(current_user)
      if game.update_attributes(game_params)
        AppMailer.update_score_notification(current_user, game).deliver
      end
    end
    
  end


  def game_params
    params.require(:game).permit(:team_one_score, :team_two_score, :is_finished)
  end
  
end