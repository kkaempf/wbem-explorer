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
    @connection = Connections.new(params[:connection])
    if @connection && @connection.save
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
    @connection = Connections.find(params[:id])
  end
  
  def update
    @connection = Connections.find(params[:id])
    unless @connection
      flash[:error] = 'No such connection to update.'
    else
      if @connection.update_attributes(params[:host])
	flash[:notice] = 'Connection was successfully updated.'
      else
	render edit_connection_path(params[:id])
	return
      end
    end
    redirect_to connections_path
  end

  def destroy
    @connection = Connections.find(params[:id])
    unless @connection
      flash[:error] = 'No such connection to delete.'
    else
      unless @connection.destroy
	flash[:error] = "Connection deletion failed"
      end
    end      
    redirect_to connections_path
  end
end
