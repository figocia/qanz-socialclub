require 'rails_helper'

describe SetMembershipController do
  
  describe 'POST create' do
    let(:alice) { Fabricate(:user)}

    context 'valid token' do
      before { alice.generate_membership_token }
      it 'sets the user as member' do
        post :create, token: alice.membership_token
        alice.reload
        expect(alice.is_member).to be true
      end

      it 'redirect to the set membership success page' do
        post :create, token: alice.membership_token
        alice.reload
        expect(response).to redirect_to setting_membership_successful_path
      end
    end

    context "invlalid token" do
      before { alice.generate_membership_token }
      it 'did not set the user as member' do
        post :create, token: "123"
        alice.reload
        expect(alice.is_member).not_to be true
      end

      it 'redirect to token expire path' do
        post :create, token: "123"
        expect(response).to redirect_to token_expire_path
      end
    end
  end
end