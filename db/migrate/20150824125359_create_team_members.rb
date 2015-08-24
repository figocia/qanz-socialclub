class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.integer :member_id, :team_id
      t.timestamps
    end
  end
end
