class CreateEventParticipants < ActiveRecord::Migration
  def change
    create_table :event_participants do |t|
      t.integer :participant_id, :event_id
      t.timestamps
    end
  end
end
