class MatchesController < ApplicationController  
  def index
    @matches = Match.all
  end

  def new
    @match = Match.new
    @teams = Team.all
    @match.games.build
  end

  def edit
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])
    @match[:winner_id] = match_winner
    if @match.update_attributes match_params
      flash[:success] = "Match updated successfully"
      redirect_to matches_path
    else
      render "edit"
    end  
  end

  def create
    @match = Match.new match_params
    @match[:winner_id] = match_winner
    if @match.save
      flash[:success] = "Match created successfully"
      redirect_to matches_path
    else
      render "new"
    end  
  end

  def destroy
    Match.find(params[:id]).destroy
    flash[:success] = "match deleted"
    redirect_to matches_path
  end

  def ranking
    @teams_ranking = Match.team_ranking
  end

  private
  def match_winner
    games_attributes = params[:match][:games_attributes]
    winner_game = []
    games_attributes.each do |k, game|
      winner_game << team_win_game(game)
    end
    if(winner_game.first == winner_game.second)
      winner_id = winner_game.first
    else
      winner_id = winner_game.third
    end
    return winner_id
  end
  def team_win_game(game)
    if(game[:team1_score].to_i > game[:team2_score].to_i)
      team_win = params[:match][:team_one_id]
    else
      team_win = params[:match][:team_two_id]
    end
  end  
  def match_params
    params.require(:match).permit(:team_one_id, :team_two_id, :winner_id, games_attributes: [:id, :team1_score, :team2_score])
  end
end
