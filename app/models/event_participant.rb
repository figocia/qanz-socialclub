class EventParticipant < ActiveRecord::Base
  belongs_to :participant, class_name: 'User'
  belongs_to :event

  validates_uniqueness_of :participant, scope: [:event_id]
end