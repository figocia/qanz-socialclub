class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :this_year, :logged_in?, :current_user

  def this_year
    @year = Date.today.year
  end

  def current_user
    user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

   def require_user
    if !logged_in?
      flash[:error] = 'You must be logged in to do that.'
      redirect_to root_path
    end
  end
end
