class Event < ActiveRecord::Base
  has_many :event_participants, :dependent => :destroy
  has_many :participants, through: :event_participants

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
end