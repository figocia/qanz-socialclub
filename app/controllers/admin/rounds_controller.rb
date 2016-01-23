class Admin::RoundsController < AdminsController

  before_action :set_competition
  
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
    
  end

  private

  def set_competition
    @competition = Competition.find(params[:competition_id])
  end

  def rounds_params
    params.require(:round).permit(:name)
  end
end