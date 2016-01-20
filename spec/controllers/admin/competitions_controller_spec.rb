require 'rails_helper'

describe Admin::CompetitionsController do
  
  before { login_admin}

  describe 'GET Index' do
    let!(:foosballone) { Fabricate(:competition)}
    let!(:foosballtwo) { Fabricate(:competition)}
    
    it 'assigns the right competiton attribute order by created_at desc' do
      get :index
      expect(assigns(:competitions)).to eq([foosballtwo, foosballone])
    end
    it_behaves_like 'require_admin' do
      let(:action) { get :index }      
    end

  end

  describe 'GET New' do
    it 'assigns the right competition attribute' do
      xhr :get, :new
      expect(assigns(:competition)).to be_an_instance_of Competition
    end

    it_behaves_like 'require_admin' do
      let(:action) { xhr :get, :index }      
    end
  end

  describe 'POST Create' do
    it_behaves_like 'require_admin' do
      let(:action) { xhr :post, :create, competition: {name: 'new competition'} }      
    end

    context 'valid input' do
      it 'creates the competition successfully' do
        xhr :post, :create, competition: {name: 'new competition'}
        expect(Competition.first.name).to eq('new competition')
      end
    end

    context 'invalid input' do
      it 'does not create the competition' do
        xhr :post, :create, competition: {name: ''}
        expect(Competition.all.size).to eq(0)
      end
    end
  end

  describe 'GET Show' do
    
    let(:competition_one) { Fabricate(:competition)}
    let(:teamA) { Fabricate(:team, competition: competition_one )}
    let(:teamB) { Fabricate(:team, competition: competition_one )}
    let!(:gameA) { Fabricate(:game, competition: competition_one, team_one: teamA, team_two:teamB) }
    let!(:gameB) { Fabricate(:game, competition: competition_one, team_one: teamB, team_two:teamA)}
    it_behaves_like 'require_admin' do
      let(:action) { get :show, id: competition_one.id }
    end

    it 'has the right competition attribute assgined' do
      get :show, id: competition_one.id
      expect(assigns(:competition)).to eq(competition_one)
    end


  end

  describe 'POST AutoCreateTeamMembers' do
    
    let(:competition_one) { Fabricate(:competition)}
    let!(:teamA) { Fabricate(:team, competition: competition_one )}
    let!(:teamB) { Fabricate(:team, competition: competition_one )}
    let!(:user1) { Fabricate(:user)}
    let!(:user2) { Fabricate(:user)}
    let!(:user3) { Fabricate(:user)}
    let!(:user4) { Fabricate(:user)}
    let!(:user5) { Fabricate(:user)}

    it_behaves_like 'require_admin' do
      let(:action) { xhr :post, :auto_create_team_members}
    end

    it 'auto allocate the all users to the rest of the teams' do
      xhr :post, :auto_create_team_members, competition_id: competition_one.id
      expect(competition_one.reload.unallocated_users.size).to eq(0)
    end

    it 'allocate the users evenly' do
      xhr :post, :auto_create_team_members, competition_id: competition_one.id
      expect(competition_one.teams.map(&:team_members).map(&:size)).to eq([3, 3])
    end

    it 'allocate the odd one to first team if user number not even' do
      user6 = Fabricate(:user)
      xhr :post, :auto_create_team_members, competition_id: competition_one.id
      expect(competition_one.teams.map(&:team_members).map(&:size)).to eq([4, 3])
    end

    it 'does not remove the already allocated users from teams' do
      team_member1 = Fabricate(:team_member, member: user1, team: teamA)
      team_member2 = Fabricate(:team_member, member: user2, team: teamA)
      team_member3 = Fabricate(:team_member, member: user3, team: teamA)
      team_member4 = Fabricate(:team_member, member: user4, team: teamA)
      team_member5 = Fabricate(:team_member, member: user5, team: teamA)

      xhr :post, :auto_create_team_members, competition_id: competition_one.id
      expect(teamB.team_members.size).to eq(1)
    end
  end
end