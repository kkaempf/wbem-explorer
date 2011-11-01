class UsersController < ApplicationController
  require 'will_paginate'

  def index
    list
    render :action => 'list'
  end

  def list
    @users = User.paginate :per_page => 10, :page => 1
  end

  def find
    @users = User.paginate :per_page => 10, :page => params[:page], :order => 'updated_at DESC'
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
    end
    @user = User.new(user)
    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to users_path
    else
      flash[:error] = 'User creation failed.'
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to user_path(@user)
    else
      render edit_user_path(@user)
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
