class TeamMember < ActiveRecord::Base
  belongs_to :member, class_name: 'User'
  belongs_to :team
  validates :team_id, presence: true, on: :create
  validates :member_id, presence: true, on: :create
end