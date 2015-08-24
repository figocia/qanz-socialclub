class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :round
      t.boolean :is_finished
      t.integer :team_one_score, :team_two_score, :team_one_id, :team_two_id, :competition_id
      t.timestamps
    end
  end
end
