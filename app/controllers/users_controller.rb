class UsersController < ApplicationController

  def index
    @users = User.order(:login).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    user = params[:user]
    if User.find_by_login(user[:login])
      flash[:error] = 'User already exists.'
      redirect_to new_user_path
      return
    end
    unless user[:password] == user[:password_confirmation]
      flash[:error] = 'Passwords did not match.'
      redirect_to new_user_path
      return
    else
      user.delete :password_confirmation
      user = User.new(user)
      if user.save
	flash[:notice] = 'User was successfully created.'
	redirect_to users_path
      else
	flash[:error] = 'User creation failed.'
	redirect_to new_user_path
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = params[:user]
    unless user[:password] == user[:password_confirmation]
      flash[:error] = 'Passwords did not match.'
      redirect_to edit_user_path(@user)
      return
    else
      @user = User.find(user[:login])
      unless @user
	flash[:error] = 'User does not exist.'
	redirect_to users_path
	return
      end
      user.delete :password_confirmation
      if @user.update_attributes(user)
	flash[:notice] = 'User was successfully updated.'
	redirect_to user_path(@user)
      else
	render edit_user_path(@user)
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user
      @user.destroy
    else
      flash[:notice] = 'User already deleted.'
    end
    redirect_to users_path
  end

end
