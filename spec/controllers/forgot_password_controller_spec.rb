require 'rails_helper'

describe ForgotPasswordController do
  describe 'POST Create' do
    after { ActionMailer::Base.deliveries.clear }
    context 'with valid email' do
      it 'sends the email' do
        alice = Fabricate(:user)
        post :create, email: alice.email
        expect(ActionMailer::Base.deliveries.last.to).to eq([alice.email])
      end
      it 'redirect to the confirm page' do
        alice = Fabricate(:user)
        post :create, email: alice.email
        expect(response).to redirect_to login_path
      end

      it 'sets the password token' do
        alice = Fabricate(:user)
        post :create, email: alice.email
        alice.reload
        expect(alice.reset_password_token).not_to eq(nil)
      end
    end



    context 'with empty email' do
      it 'redirect back to the forgot_password path' do
        post :create, email: ''
        expect(response).to redirect_to new_forgot_password_path
      end

      it 'errors out' do
        post :create, email: ''
        expect(flash[:error]).to eq('Cannot find the email in SocialClub system')
      end
    end
  end
end