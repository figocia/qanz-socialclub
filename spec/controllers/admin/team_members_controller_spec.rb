require 'rails_helper'

describe Admin::TeamMembersController do
  before { login_admin }

  describe 'POST Create' do
    let(:alex) { Fabricate(:user)}
    let(:team) { Fabricate(:team)}
    
    it_behaves_like 'require_admin' do
      let(:action) { xhr :post, :create, team_member: { team_id: team.id, member_id: alex.id} }
    end

    it 'creates the team member' do
      xhr :post, :create, team_member: { team_id: team.id, member_id: alex.id} 
      expect(TeamMember.first.member).to eq(alex)
    end

  end
end