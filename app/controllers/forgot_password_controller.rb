class ForgotPasswordController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user       

      user.generate_reset_password_token

      AppMailer.forgot_password(user).deliver
      redirect_to confirm_email_send_path
    else
      flash[:error] = 'Cannot find the email in SocialClub system'
      redirect_to new_forgot_password_path
    end
  end
end