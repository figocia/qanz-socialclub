class User < ActiveRecord::Base
  has_secure_password
  
  has_many :team_members, foreign_key: :member_id
  has_many :teams, through: :team_members
  has_many :event_participants, foreign_key: :participant_id
  has_many :events, through: :event_participants

  validates :email, presence: true, uniqueness: true,  on: :create
  validates :password, length: {minimum: 5}, allow_nil: true

  def comming_to_event?(event)
    event.participants.include?(self)
  end

  def event_participant(event)

    event.event_participants.select{|ep| ep.event == event}.first
  end
end