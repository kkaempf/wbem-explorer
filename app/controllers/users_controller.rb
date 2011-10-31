class UsersController < ApplicationController
  require_dependency 'users'
  require_dependency 'hosts'
  require 'will_paginate'

  def index
    list
    render :action => 'list'
  end

  def list
    @users = Users.paginate :per_page => 10, :page => 1
  end

  def find
    @users = Users.paginate :per_page => 10, :page => params[:page], :order => 'updated_at DESC'
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
    redirect_to users_path
  end

end
