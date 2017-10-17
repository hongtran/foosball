require 'rails_helper'

RSpec.describe TeamPlayer, type: :model do
  let(:user1){user1 = User.create(first_name: "test", last_name: "test")}
  let(:user2){user2 = User.create(first_name: "test", last_name: "test")}
  let(:team1){team1 = Team.create(name: "Real", :team_players_attributes => [{user: user1}, {user: user2}])}
  describe "destroy team" do
    it "destroy team when destroy last team_player association" do
      id = team1.id
      Team.last.team_players.first.destroy
      Team.last.team_players.first.destroy
      expect(team1).not_to eq Team.last
    end  
  end  
end
