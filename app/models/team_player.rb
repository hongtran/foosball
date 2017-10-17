class TeamPlayer < ApplicationRecord
  belongs_to :user
  belongs_to :team
  after_destroy :destroy_team

  def destroy_team
    self.team.destroy if self.team.team_players.count == 0
  end
end
