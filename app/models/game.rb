class Game < ApplicationRecord
  belongs_to :team_win, class_name: "Team", optional: true
  belongs_to :match
  validates :team1_score, :inclusion => 0..10
  validates :team2_score, :inclusion => 0..10

  def team_win_name
    return self.match.team_one.name if self.team1_score > self.team2_score
    return self.match.team_two.name
  end
end
