class Team < ApplicationRecord
  belongs_to :player1, class_name: "User"
  belongs_to :player2, class_name: "User", optional: true
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
end
