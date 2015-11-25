require 'rails_helper'

describe Admin::BatchUsersGenerationController do
  
  describe 'GET New' do
    it_behaves_like 'require_admin' do
      let(:action) { get :new }
    end
  end
end