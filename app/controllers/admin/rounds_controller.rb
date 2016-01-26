class Admin::RoundsController < AdminsController

  before_action :set_competition, except: [:auto_create_games]
  
  def index    
    @rounds = @competition.rounds
  end

  def show    
    @round = Round.find(params[:id])
  end

  def new
    @round = Round.new
  end

  def create
    @round = @competition.rounds.build(rounds_params)    

    respond_to do |format|
      if @round.save
        format.js { render js: "window.location = '#{admin_competition_round_path(@competition, @round)}';" }
      else
        format.json { render json: @round.errors.full_messages,
                                     status: :unprocessable_entity }
      end
    end
  end

  def auto_create_games
    @round = Round.find(params[:round_id])
    respond_to do |format|
      begin
        @round.auto_create_games
        format.js
      rescue
        format.js { flash[:error] = 'Game already exsit in this round'}
      end
    end
    
  end

  def destroy
    round = Round.find(params[:id])
    round.destroy if round
    respond_to do |format|
      format.js
    end
  end

  private

  def set_competition
    @competition = Competition.find(params[:competition_id])
  end

  def rounds_params
    params.require(:round).permit(:name)
  end
end