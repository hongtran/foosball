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
    let(:match3){match3 = Match.new(team_one: team1, team_two: team2, winner: team1)}
    let(:game1){game1 = Game.create(team1_score: 10, team2_score: 5, team_win: nil, match: match3)}
    let(:game2){game2 = Game.create(team1_score: 8, team2_score: 5, team_win: nil, match: match3)}
    let(:team3){team3 = Team.create(name: "team3", player1: user1, player2: user2)}
    let(:match4){match4 = Match.new(team_one: team1, team_two: team3, winner: team1)}
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

    it "check match winner when team win 2 games" do
      match3.save
      expect(match3.winner).to eq team1
    end  

    it "check players uniqueness in match" do
      match4.save
      expect(match4.errors[:players]).to include "in a match has to uniqueness"
    end  
  end  
end
