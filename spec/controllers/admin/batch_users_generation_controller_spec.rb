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

  describe 'POST Update_users' do    
    let(:alex) { Fabricate(:user) }
    let(:tony) { Fabricate(:user) }
    
    it_behaves_like 'require_admin' do
      let(:action) { post :update_users }  
    end

    context 'valid update' do      
      before { login_admin }

      it 'update the users admin status in batch successfully' do
        post :update_users, user_datas: [{id: alex.id, is_admin: true, is_member: false }, { id: tony.id, is_admin: false, is_member: true }]
        alex.reload
        tony.reload
        expect([alex.is_admin?, tony.is_admin?]).to eq([true, false])
      end

      it 'update the users member status in batch successfully' do
        post :update_users, user_datas: [{id: alex.id, is_admin: true, is_member: false }, { id: tony.id, is_admin: false, is_member: true }]
        alex.reload
        tony.reload
        expect([alex.is_member, tony.is_member]).to eq([false, true])
      end

      it 'redirect to the user index path' do
        post :update_users, user_datas: [{id: alex.id, is_admin: true, is_member: false }, { id: tony.id, is_admin: false, is_member: true }]        
        expect(response).to redirect_to admin_batch_users_generation_index_path
      end
    end

    context 'invalid update' do
      before { login_admin }

      it 'errors out' do
        post :update_users, user_datas: [{id: alex.id, is_admin: true, is_member: false }, { id: tony.id, is_admin: nil, is_member: true }]
        expect(flash[:error]).to be_present
      end

      it 'revert back the transaction' do
        post :update_users, user_datas: [{id: alex.id, is_admin: true, is_member: false }, { id: tony.id, is_admin: true, is_member: nil }]
        alex.reload
        expect(alex.is_admin).not_to be true
      end
    end



  end

end