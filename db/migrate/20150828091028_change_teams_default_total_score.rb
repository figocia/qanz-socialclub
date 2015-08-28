class ChangeTeamsDefaultTotalScore < ActiveRecord::Migration
  def change
    change_column :teams, :total_score, :integer, default: 0
  end
end
