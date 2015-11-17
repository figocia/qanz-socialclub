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

  describe 'POST Create' do
    context 'with valid password' do
      it 'resets the password' do
        alice = Fabricate(:user, reset_password_token: '1234')
        post :create, password: '1234567', reset_password_token: '1234' 
        alice.reload
        expect(alice.authenticate('1234567')).to eq(alice)
      end  
      it 'clears the password token' do
        alice = Fabricate(:user, reset_password_token: '1234')
        post :create, password: '1234567', reset_password_token: '1234' 
        alice.reload
        expect(alice.reset_password_token).to eq(nil)
      end
    end

    context 'with invlaid password' do
      it 'redirect to the show path' do
        alice = Fabricate(:user, reset_password_token: '1234')
        post :create, password: '123', reset_password_token: '1234' 
        expect(response).to redirect_to new_reset_password_path(reset_password_token: alice.reset_password_token)
      end

      it 'errors out' do      
        alice = Fabricate(:user, reset_password_token: '1234')
        post :create, password: '123', reset_password_token: '1234' 
        expect(flash[:error]).to eq("Password must be minimun 5 character")
      end
    end
  end
end