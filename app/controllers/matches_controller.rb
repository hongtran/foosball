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
    games_attributes = params[:match][:games_attributes]
    winner_game = []
    games_attributes.each do |k, game|
      winner_game << team_win_game(game)
    end
    if(winner_game.third.present?)
      @match.games.third[:team_win_id] = winner_game.third
    end

    if(winner_game.first == winner_game.second)
      @match[:winner_id] = winner_game.first
    else
      @match[:winner_id] = winner_game.third
    end

    @match.games.first[:team_win_id] = winner_game.first
    if winner_game.size > 1
      @match.games.second[:team_win_id] = winner_game.second
    end
    if @match.update_attributes match_params
      flash[:success] = "Match updated successfully"
      redirect_to matches_path
    else
      render "edit"
    end  
  end

  def create
    @match = Match.new match_params
    games_attributes = params[:match][:games_attributes]
    winner_game = []
    games_attributes.each do |k, game|
      winner_game << team_win_game(game)
    end
    if(winner_game.third.present?)
      @match.games.third[:team_win_id] = winner_game.third
    end
    if(winner_game.first == winner_game.second)
      @match[:winner_id] = winner_game.first
    else
      @match[:winner_id] = winner_game.third
    end
    @match.games.first[:team_win_id] = winner_game.first
    if winner_game.size > 1
      @match.games.second[:team_win_id] = winner_game.second
    end
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
