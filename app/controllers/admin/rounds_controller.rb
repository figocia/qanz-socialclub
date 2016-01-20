class Admin::RoundsController < AdminsController
  def index
      @competition = Competition.find(params[:competition_id])
      @rounds = @competition.rounds
  end
end