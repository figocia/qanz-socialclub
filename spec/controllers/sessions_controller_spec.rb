require 'rails_helper'

describe SessionsController do 
  describe 'GET New' do
    it 'render the new template' do
      get :new
      expect(response).to render_template :new
    end

    it 'redirect to home path if logged in already' do
      login_current_user
      get :new
      expect(response).to redirect_to home_path
    end
  end 

  describe 'POST Create' do
    let(:user) { Fabricate(:user, email: 'example@example.com', password: '12345') }
    it 'redirects to homepath when logged in successful' do    
      post :create, email: user.email, password: '12345'
      expect(response).to redirect_to home_path     
    end

    it 'fails when username not exsit' do
      post :create, email: '1234@1234.com', password: '12344'
      expect(response).to redirect_to login_path
    end 
    it 'fails when password not match' do      
      post :create, email: user.email, password: '12346'
      expect(response).to redirect_to login_path
    end
  end

  describe 'GET Destroy' do
    before { login_current_user }
    it 'redirects to root path' do      
      get :destroy
      expect(response).to redirect_to root_path
    end

    it 'logs out the user' do
      get :destroy
      expect(current_user).to be nil
    end
  end
end