class ForgotPasswordController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user       

      user.generate_reset_password_token

      AppMailer.forgot_password(user).deliver
      flash[:notice] = 'Reset password email sent, please check your email.'
      redirect_to login_path
    else
      flash[:error] = 'Cannot find the email in SocialClub system'
      redirect_to new_forgot_password_path
    end
  end
end