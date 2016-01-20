require 'rails_helper'

describe Admin::TeamMembersController do
  before { login_admin }

  describe 'POST Create' do
    let(:competition) {Fabricate(:competition)}
    let(:alex) { Fabricate(:user)}
    let(:team) { Fabricate(:team, competition: competition)}
    let(:teamB) { Fabricate(:team, competition: competition)}

    it_behaves_like 'require_admin' do
      let(:action) { xhr :post, :create, team_member: { team_id: team.id, member_id: alex.id} }
    end

    it 'creates the team member' do
      xhr :post, :create, team_member: { team_id: team.id, member_id: alex.id} 
      expect(TeamMember.first.member).to eq(alex)
    end

    it 'dissociate with any team other than this new team under the same competition' do
      team_member_old = Fabricate(:team_member, member: alex)
      team_member_same_competition = Fabricate(:team_member, member: alex, team: teamB)

      xhr :post, :create, team_member: { team_id: team.id, member_id: alex.id}, old_team_member_id: team_member_same_competition.id 
      expect(TeamMember.all.size).to eq(2)
    end
  end

  describe 'DELETE Destroy' do
    it 'deletes the team member' do
      team_member_old = Fabricate(:team_member)

      xhr :delete, :destroy, id: team_member_old.id
      expect(TeamMember.all.size).to eq(0)  
    end
    
  end
end