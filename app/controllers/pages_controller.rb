class PagesController < ApplicationController
  before_action :require_user, only: :home
  
  def home
    @competitions = Competition.order('is_finished, created_at DESC').all
  end
end