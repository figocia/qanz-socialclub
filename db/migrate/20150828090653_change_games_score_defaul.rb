class ChangeGamesScoreDefaul < ActiveRecord::Migration
  def change
    change_column :games, :team_one_score, :integer, default: 0
    change_column :games, :team_two_score, :integer, default: 0
  end
end
