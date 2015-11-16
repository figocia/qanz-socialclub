require 'rails_helper' 

describe ResetPasswordController do
  
  let(:alice) { Fabricate(:user, reset_password_token: "123")}

  describe 'GET New' do
    it 'sets the right user instance attribute' do
      get :new, reset_password_token: alice.reset_password_token
      expect(assigns(:user)).to eq(alice)
    end

    it 'redirect to token expire path if cannot find user' do
      get :new, reset_password_token: '1'
      expect(response).to redirect_to token_expire_path
    end
  end
end