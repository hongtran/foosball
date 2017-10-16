require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "check validate game" do
    let(:user1){user1 = User.create(first_name: "test", last_name: "test")}
    let(:user2){user2 = User.create(first_name: "abc", last_name: "xyz")}
    let(:team1){team1 = Team.create(name: "Real", player1: user1, player2: nil)}
    let(:team2){team2 = Team.create(name: "Barca", player1: user2, player2: nil)}
    let(:match){match = Match.create(team_one: team1, team_two: team2, winner: team1)}
    let(:game){game = Game.new(team1_score: -2, team2_score: -5, team_win: team1, match: match)}
    let(:game1){game1 = Game.new(team1_score: 10, team2_score: 5, team_win: nil, match: match)}
    it "check score from 0-10" do
      game.save
      expect(game.errors[:team1_score]).to include "is not included in the list"
      expect(game.errors[:team2_score]).to include "is not included in the list"
    end

    it "check team name win" do
      game1.save
      expect(game1.team_win_name).to eq team1.name
    end  
  end  
end
