class ConnectionsController < ApplicationController
  def index
    @connections = Connections.paginate :per_page => 10, :page => 1
  end

  def find
    @hosts = Hosts.paginate :per_page => 10, :page => params[:page], :order => 'updated_at DESC'
  end

  def connect
    @mode = :connect
    @connections = Connections.paginate :per_page => 10, :page => 1
    render :index
  end

  def new
    session[:connection] = nil
  end

  def create
    connection = Connections.new(params[:connection])
    if connection
      redirect_to home_path
    else
      redirect_to new_connection_path
    end
  end
  
  def edit
  end
  
  def update
  end

  def destroy
  end
end
