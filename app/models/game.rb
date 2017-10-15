class Game < ApplicationRecord
  belongs_to :team_win, class_name: "Team"
  belongs_to :match
end
