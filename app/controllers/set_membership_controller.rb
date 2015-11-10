class SetMembershipController < ApplicationController
  def confirm
    user = User.find_by(membership_token: params[:token])
    if user.nil?
      redirect_to token_expire_path
    else
      user.set_is_member(true)
      user.clear_membership_token
      redirect_to setting_membership_successful_path
    end

  end
end