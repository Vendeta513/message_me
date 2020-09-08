class UsersController < ApplicationController

  before_action :current_logged_in?, only: [:new, :create]
  
  def index
    
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You've successfully signed up"
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def current_logged_in?
    if logged_in?
      flash[:error] = "You're already logged in"
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end