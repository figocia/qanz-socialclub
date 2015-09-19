class Event < ActiveRecord::Base
  has_many :event_participants, :dependent => :destroy
  has_many :participants, through: :event_participants
end