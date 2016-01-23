class Round < ActiveRecord::Base
  belongs_to :competition
  has_many :games, -> { order 'created_at DESC' }, :dependent => :destroy

  validates_uniqueness_of :name, scope: :competition_id

  def previous
    competition.rounds.where("created_at < ?", created_at).last
  end

  def next
    competition.rounds.where("created_at > ?", created_at).first
  end

  def next_match_up
    teamAs = games.collect{|game| game.team_one_id}
    teamBs = games.collect{|game| game.team_two_id}

    teamA_last = teamAs.pop
    teamB_last = teamBs.pop

    # mismatch by one index between left and right
    teamAs.push(teamB_last)
    teamBs.unshift(teamA_last)

    return {left: teamAs, right: teamBs }
  end
end