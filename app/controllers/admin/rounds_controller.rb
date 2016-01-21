class Admin::RoundsController < AdminsController
  
  def index
      @competition = Competition.find(params[:competition_id])
      @rounds = @competition.rounds
  end

  def show
    @competition = Competition.find(params[:competition_id])
    @round = Round.find(params[:id])
  end

  def new
    @competition = Competition.find(params[:competition_id])
  end
end