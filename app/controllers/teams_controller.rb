class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
    @users = User.all
  end

  def edit
    @team = Team.find(params[:id])
    @users = User.all
  end

  def update
    @team = Team.find(params[:id])
    @users = User.all
    if @team.update_attributes(team_params)
      flash[:success] = "You have update team successfully"
      redirect_to teams_path
    else
      render "edit"
    end
  end

  def destroy
    @team = Team.find(params[:id]).destroy
    flash[:success] = "team deleted successfully"
    redirect_to teams_path
  end

  def create
    @team = Team.new team_params
    @users = User.all
    if @team.save
      flash[:success] = "You have create team successfully"
      redirect_to teams_path
    else
      render :new
    end
  end

  def ranking
    @teams = Team.team_ranking
  end

  private
  def team_params
    params.require(:team).permit(:name, :player1_id, :player2_id)
  end
end
