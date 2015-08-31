class DeleteTeamsTotalScore < ActiveRecord::Migration
  def change
    remove_column :teams, :total_score
  end
end
