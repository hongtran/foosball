class Team < ApplicationRecord
  belongs_to :player1, class_name: "User", foreign_key: "player1_id"
  belongs_to :player2, class_name: "User", foreign_key: "player2_id", optional: true
  has_many :team_one_matches, class_name: "Match", foreign_key: "team_one_id", dependent: :destroy
  has_many :team_two_matches, class_name: "Match", foreign_key: "team_two_id", dependent: :destroy
  validates :player1, presence: true
  validates :player1, uniqueness: {scope: :player2}
  validates :player2, uniqueness: {scope: :player1}
  validates :name, presence: true
  validate :unique_player_on_team

  def unique_player_on_team
    unless player1 != player2
      errors.add(:player, "has to be different")
    end
  end

  def matches
    team_one_matches + team_two_matches
  end
end
