class ResetPasswordController < ApplicationController

  def new
    @set_via_email = !!params[:reset_password_token]
    @user = !!@set_via_email ? User.find_by(reset_password_token: params[:reset_password_token]) : current_user
    redirect_to token_expire_path if @user.nil?
  end

  def create
    user = !!params[:reset_password_token] ? User.find_by(reset_password_token: params[:reset_password_token]) : current_user
    user.password = params[:password]
    if user.save
      flash[:notice] = "Password reset done"
      user.clear_reset_password_token if params[:reset_password_token].present?
      redirect_to login_path
    else
      flash[:error] = "Password must be minimun 5 character"
      redirect_to new_reset_password_path(reset_password_token: params[:reset_password_token])
    end
  end
end