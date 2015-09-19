class PagesController < ApplicationController
  before_action :require_user, only: :home
  
  def home
    @competitions = Competition.order('is_finished, created_at DESC').all
  end

  def front
    redirect_to home_path if logged_in?
  end
end