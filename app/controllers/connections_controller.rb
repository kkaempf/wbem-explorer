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
    if connection && connection.save
      flash[:notice] = 'Connection was successfully created.'
      redirect_to connections_path
    else
      flash[:error] = 'Connection creation failed.'
      redirect_to new_connection_path
    end
  end
  
  def show
    @connection = Connections.find(params[:id])
  end

  def edit
  end
  
  def update
  end

  def destroy
  end
end
