class SetMembershipController < ApplicationController
  def create
    user = User.find_by(membership_token: params[:token])
    if user.nil?
      redirect_to token_expire_path
    else
      user.set_is_member(true)
      redirect_to setting_membership_successful_path
    end

  end
end