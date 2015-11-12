class User < ActiveRecord::Base
  has_secure_password
  
  has_many :team_members, foreign_key: :member_id
  has_many :teams, through: :team_members
  has_many :event_participants, foreign_key: :participant_id
  has_many :events, -> { order("time")}, through: :event_participants

  validates :email, presence: true, uniqueness: true,  on: :create
  validates :password, length: {minimum: 5}, allow_nil: true

  def comming_to_event?(event)
    event.participants.include?(self)
  end

  def event_participant(event)

    event.event_participants.select{|ep| ep.event == event}.first
  end

  def is_member?
    is_member    
  end

  def generate_membership_token
    self.membership_token = SecureRandom.urlsafe_base64    
    save    
  end

  def generate_reset_password_token
    self.reset_password_token = SecureRandom.urlsafe_base64    
    save    
  end

  def set_is_member(ismember)
    self.is_member = ismember
    save
  end

  def clear_membership_token
    self.membership_token = nil
    save
  end

  def clear_reset_password_token
    self.reset_password_token = nil
    save
  end

end