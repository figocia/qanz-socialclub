class Admin::CompetitionManagementController < AdminsController
  def index
    @competitions = Competition.order('is_finished, created_at DESC').all
  end
end