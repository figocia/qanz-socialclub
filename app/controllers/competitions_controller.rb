class CompetitionsController < ApplicationController 
  before_action :require_user
  def show
    @competition = Competition.find(params[:id])
  end
end