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
    context  'with valid input' do
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

      it 'redirect to batch users generatinos index' do
        post :create, emails: "test1@test.com;test2@test.com; test3@test.com"
        expect(response).to redirect_to admin_batch_users_generation_index_path
      end

      it 'populates the username correctly' do
        post :create, emails: "test1@test.com;test2@test.com; YUFEI.CHEN@test.com"
        expect(User.last.name).to eq('YUFEI CHEN')
      end
    end

    context 'with invalid input' do
      before { login_admin }
      it 'will not create any user if the input contain invalid format' do
        post :create, emails: "test1@test.com;test2test.com; test3@test.com"
        expect(User.all.size).to eq(1)
      end

      it 'will render new when failed' do
        post :create, emails: "test1@test.com;test2test.com; test3@test.com"
        expect(response).to render_template :new
      end

    end
  end

  describe 'GET Index' do
    let!(:alice) { Fabricate(:user) }
    let!(:tony) { Fabricate(:user) }
    it_behaves_like 'require_admin' do
      let(:action) { get :index }      
    end

    it 'have the right users assign' do
      login_admin
      get :index
      expect(assigns(:users).size).to eq(3)
    end
  end
end