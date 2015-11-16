class ResetPasswordController < ApplicationController

  def new
    @user = User.find_by(reset_password_token: params[:reset_password_token])
    redirect_to token_expire_path if @user.nil?
  end
end