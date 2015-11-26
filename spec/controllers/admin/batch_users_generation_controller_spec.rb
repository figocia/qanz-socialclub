require 'rails_helper'

describe Admin::BatchUsersGenerationController do
  
  describe 'GET New' do
    it_behaves_like 'require_admin' do
      let(:action) { get :new }
    end
  end

  describe 'POST Create' do
    it_behaves_like 'require_admin' do
      let(:action) { post :create }      
    end
    context 'with valid input' do
      before { login_admin }
      it 'creates the new users successfully' do
        post :create, emails: "test1@test.com;test2@test.com; test3@test.com"
        expect(User.all.size).to eq(4)
      end

      it 'creates the new users succesfully and ignore the existing one' do
        test1 = Fabricate(:user, email: 'test1@test.com')
        post :create, emails: "test1@test.com;test2@test.com; test3@test.com"
        expect(User.all.size).to eq(4)
      end      
    end
  end
end