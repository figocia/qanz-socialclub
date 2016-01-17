class Admin::CompetitionsController < AdminsController
  def index
    @competitions = Competition.order('is_finished, created_at DESC').all
  end

  def new
    @competition = Competition.new
  end
end