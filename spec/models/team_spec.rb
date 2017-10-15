require 'rails_helper'

RSpec.describe Team, type: :model do
  describe "check validate team" do
    let(:user){user = User.create(first_name: "test", last_name: "test")}
    let(:user1){user1 = User.create(first_name: "abc", last_name: "xyz")}
    let(:team){team = Team.new(name: "Man U", player1: nil, player2: nil)}
    let(:team1){team1 = Team.new(name: "", player1: user, player2: nil)}
    let(:team2){team2 = Team.new(name: "Braca", player1: user, player2: user)}
    it "check team has at least 1 player" do
      team.save
      expect(team.errors[:player1]).to include "must exist"
    end

    it "check presence of name of team" do
      team1.save
      expect(team1.errors[:name]).to include "can't be blank"
    end

    it "check 2 players in team have to different" do
      team2.save
      expect(team2.errors[:player]).to include "has to be different"
    end

    it "check the team is unique" do
      teamA = Team.new(name: "Real", player1: user, player2: user1)
      teamA.save
      teamB = Team.new(name: "Real", player1: user, player2: user1)
      teamB.save
      expect(teamB.errors[:player1]).to include "has already been taken"
      expect(teamB.errors[:player2]).to include "has already been taken"
    end  
  end  
end
