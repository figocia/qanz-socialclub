class Round < ActiveRecord::Base
  belongs_to :competition
  has_many :games, :dependent => :destroy

  validates_uniqueness_of :name, scope: :competition_id

  def previous
    competition.rounds.where("created_at < ?", created_at).last
  end

  def next
    competition.rounds.where("created_at > ?", created_at).first
  end
end