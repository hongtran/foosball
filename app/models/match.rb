class Match < ApplicationRecord
  belongs_to :team_one, class_name: "Team", foreign_key: "team_one_id"
  belongs_to :team_two, class_name: "Team", foreign_key: "team_two_id"
  belongs_to :winner, class_name: "Team", foreign_key: "winner_id"
  has_many :games, dependent: :destroy
  validate :unique_team_on_match
  validate :validate_game_count
  accepts_nested_attributes_for :games, limit: 3
  
  def unique_team_on_match
    unless team_one != team_two
      errors.add(:team, "has to be different")
    end
  end

  def validate_game_count
    if self.games.size < 2
      errors.add(:game, "Need at least 2 games per match")
    end  
  end

  def self.team_sources
    Team.all
  end

  def self.team_ranking
    result = team_sources.map { |source| team_for(source) }.sort_by{|e| e[:percentage]}.reverse
  end

  def self.team_for(source)
    {
      source: source,
      matches_played: matches_for(source),
      wins: wins_for(source),
      percentage: percentage_for(source)
    }
  end

  def self.percentage_for(source)
    return 0 if matches_for(source) == 0
    ((wins_for(source).to_f/matches_for(source)) * 100).round(2)
  end
  def self.matches_for(source)
    data_scope_matches(source).count()
  end

  def self.wins_for(source)
    data_scope_wins(source).count()
  end

  def self.data_scope_wins(source)
    Match.where(winner: source)
  end

  def self.data_scope_matches(source)
    Match.where("team_one_id = ? OR team_two_id = ?", source.id, source.id)
  end
end
