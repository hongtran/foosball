class User < ApplicationRecord
  has_many :player1_teams, class_name: "Team", foreign_key: "player1_id", dependent: :destroy
  has_many :player2_teams, class_name: "Team", foreign_key: "player2_id", dependent: :destroy
  validates :first_name, presence: true
  validates :last_name, presence: true

  def teams
    player1_teams + player2_teams
  end
end
