class Game < ApplicationRecord
  belongs_to :team_win, class_name: "Team"
  belongs_to :match
  validates :team1_score, :inclusion => 0..10
  validates :team2_score, :inclusion => 0..10
end
