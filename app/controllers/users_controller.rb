class UsersController < ApplicationController
  require_dependency 'users'
  require_dependency 'hosts'
  require 'will_paginate'

  def index
    list
    render :action => 'list'
  end

  def list
    @user_pages, @users = Users.paginate :per_page => 10, :page => 1
  end

  def show
    @user = Users.find(params[:id])
  end

  def new
    @user = Users.new
  end

  def create
    @user = Users.new(params[:user])
    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @user = Users.find(params[:id])
  end

  def update
    @user = Users.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'edit'
    end
  end

  def destroy
    Users.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def login
    session[:user] = nil
  end
  
  def verifylogin
    user = params[:user]
    name = user[:login]
    password = user[:password]
    user = Users.find_by_login( name )
    unless user
      flash[:alert] = 'Unknown user.'
      redirect_to :action => 'login'
    else
      unless user.password == password
        flash[:alert] = 'Wrong credentials.'
        redirect_to :action => 'login'
      else
	session[:user] = user
	redirect_to :controller => 'start', :action => 'index'
      end
    end
  end
  
  def logout
    session[:user] = nil
    redirect_to :controller => 'start', :action => 'index'
  end

end
