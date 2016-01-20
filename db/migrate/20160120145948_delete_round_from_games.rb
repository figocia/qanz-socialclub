class DeleteRoundFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :round
  end
end
