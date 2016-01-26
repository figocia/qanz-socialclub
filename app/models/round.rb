class Round < ActiveRecord::Base
  belongs_to :competition
  has_many :games, -> { order 'created_at DESC' }, :dependent => :destroy

  validates_uniqueness_of :name, scope: :competition_id

  def previous
    competition.rounds.where("created_at < ?", created_at).first
  end

  def next
    competition.rounds.where("created_at > ?", created_at).next
  end

  def auto_generate_match_up
    teamAs = Array.new
    teamBs = Array.new
    
    if previous
      teamAs = previous.games.collect{|game| game.team_one_id}
      teamBs = previous.games.collect{|game| game.team_two_id}
      

      teamA_last = teamAs.pop
      teamB_last = teamBs.pop

      # mismatch by one index between left and right
      teamAs.push(teamB_last)
      teamBs.unshift(teamA_last)
    else

      size = competition.teams.size
      teamAs = competition.teams[0..size/2 - 1].map(&:id)
      teamBs = competition.teams[(size/2)..size].map(&:id)
    end
    return {left: teamAs, right: teamBs }
  end

  def auto_create_games
    match_ups = auto_generate_match_up

    ActiveRecord::Base.transaction do

      match_ups[:left].size.times do |i|
        
        new_game = Game.new( team_one_id: match_ups[:left][-i-1], team_two_id: match_ups[:right][-i-1], round: self, competition: self.competition)
        new_game.save!
      end
    end
  end
end