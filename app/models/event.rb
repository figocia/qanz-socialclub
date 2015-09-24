class Event < ActiveRecord::Base
  has_many :event_participants, :dependent => :destroy
  has_many :participants, through: :event_participants

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  def is_free?(user)
    !member_only or user.is_member?
  end
  
  def number_of_people_comming
    participants.size
  end
end