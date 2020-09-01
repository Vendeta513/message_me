class SessionsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def new
    
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You've successfully logged in"
      redirect_to root_path
    else
      flash[:error] = "There's something wrong with your credentials"
      render 'new'   
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You've successfully logged out"
    redirect_to login_path
  end

  private

  def logged_in_user
    if logged_in?
      flash[:error] = "You are already logged in"
      redirect_to root_path
    end
  end
end