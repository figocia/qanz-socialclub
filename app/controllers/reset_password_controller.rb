class ResetPasswordController < ApplicationController

  def new
    @user = User.find_by(reset_password_token: params[:reset_password_token])
    redirect_to token_expire_path if @user.nil?
  end

  def create
    user = User.find_by(reset_password_token: params[:reset_password_token])
    user.password = params[:password]
    if user.save
      flash[:notice] = "Password reset done"
      user.clear_reset_password_token
      redirect_to login_path
    else
      flash[:error] = "Password must be minimun 5 character"
      redirect_to new_reset_password_path(reset_password_token: params[:reset_password_token])
    end
  end
end