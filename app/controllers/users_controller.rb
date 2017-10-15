class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "You have update user successfully"
      redirect_to users_path
    else
      render "edit"
    end  
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "user deleted"
    redirect_to users_path
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "User created successfully"
      redirect_to users_path
    else
      render "new"
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end  
end
