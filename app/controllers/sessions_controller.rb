class SessionsController < ApplicationController
  def new
    session[:user] = nil
  end

  def create
    name = params[:login]
    password = params[:password]
    user = User.find_by_login( name )
    unless user
      flash[:alert] = "Unknown user '#{name}'."
      redirect_to new_session_path
    else
      unless user.password == password
        flash[:alert] = 'Wrong credentials.'
        redirect_to new_session_path
      else
	session[:user] = user
	redirect_to home_path
      end
    end
  end
  
  def destroy
    session[:user] = nil
    redirect_to home_path
  end

end
