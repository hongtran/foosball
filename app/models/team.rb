class Team < ApplicationRecord
  has_many :team_players, dependent: :destroy
  has_many :team_one_matches, class_name: "Match", foreign_key: "team_one_id", dependent: :destroy
  has_many :team_two_matches, class_name: "Match", foreign_key: "team_two_id", dependent: :destroy
  validates :name, presence: true
  accepts_nested_attributes_for :team_players, :allow_destroy => true
  validate :unique_player_on_team
  validate :requie_at_least_one_player

  def requie_at_least_one_player
    errors.add(:base, "You must provide at least one player") if team_players.size < 1
  end

  def unique_player_on_team
    if(team_players.second.present? and team_players.first.user == team_players.second.user)
      errors.add(:player, "has to be different")
    end
  end

  def matches
    team_one_matches + team_two_matches
  end
end
