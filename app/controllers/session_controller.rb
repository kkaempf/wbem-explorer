class SessionController < ApplicationController
  def new
    session[:user] = nil
  end

  def create
    user = params[:user]
    name = user[:login]
    password = user[:password]
    user = Users.find_by_login( name )
    unless user
      flash[:alert] = 'Unknown user.'
      redirect_to login_user
    else
      unless user.password == password
        flash[:alert] = 'Wrong credentials.'
        redirect_to login_user
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
