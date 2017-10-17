class User < ApplicationRecord
  has_many :team_players, dependent: :destroy
  validates :first_name, presence: true
  validates :last_name, presence: true

  def teams
    player1_teams + player2_teams
  end

  def full_name
    first_name + " " + last_name
  end
end
