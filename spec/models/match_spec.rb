require 'rails_helper'

RSpec.describe Match, type: :model do
  describe "check validate match" do
    let(:user1){user1 = User.create(first_name: "test", last_name: "test")}
    let(:user2){user2 = User.create(first_name: "abc", last_name: "xyz")}
    let(:team1){team1 = Team.create(name: "Real", player1: user1, player2: nil)}
    let(:team2){team2 = Team.create(name: "Barca", player1: user2, player2: nil)}
    let(:match){match = Match.new(team_one: team1, team_two: team1, winner: team1)}
    let(:match1){match1 = Match.new(team_one: team1, team_two: nil, winner: team1)}
    let(:match2){match2 = Match.new(team_one: team1, team_two: team1, winner: nil)}
    it "check 2 teams in match have to different" do
      match.save
      expect(match.errors[:team]).to include "has to be different"
    end

    it "check each match has 2-3 games" do
      match.save
      expect(match.errors[:game]).to include "Need at least 2 games per match"
    end

    it "check not valid without 2 teams" do
      match1.save
      expect(match1.errors[:team_two]).to include "must exist"
    end

    it "match has one winning team" do
      match2.save
      expect(match2.errors[:winner]).to include "must exist"
    end  
  end  
end
