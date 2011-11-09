class ConnectionsController < ApplicationController
  private
  def _disconnect
    session[:connection] = nil
    session[:url] = nil
  end

  public
  def connect
    require 'wbem_client'
    id = params[:connection_id]
    connection = Connection.find(id)
    unless connection
      flash[:error] = "Connect failed: no such connection"
      redirect_to request.referer
      return
    end

    _disconnect

    url = connection.to_uri
    begin
      c = WbemClient.connect url
      STDERR.puts "Client at #{c}"
      begin
	c.identify
	session[:connection] = id
	session[:url] = url
      rescue AuthError
	flash[:error] = "Wrong credentials for #{connection}"
      rescue Exception => e
	flash[:error] = "Cannot access #{connection}: #{e.class} #{e}"
      end
    rescue Exception => e
      flash[:error] = "Connect failed: #{e}"
    end
    redirect_to request.referer
  end

  def disconnect
    _disconnect
    redirect_to home_path
  end

  def index
    @connections = Connection.paginate :per_page => 10, :page => 1
  end

  def find
    @hosts = Hosts.paginate :per_page => 10, :page => params[:page], :order => 'updated_at DESC'
  end

  def new
    session[:connection] = nil
    @connection = Connection.new
  end

  def create
    @connection = Connection.new(params[:connection])
    if @connection && @connection.save
      flash[:notice] = 'Connection was successfully created.'
      redirect_to connections_path
    else
      flash[:error] = 'Connection creation failed.'
      redirect_to new_connection_path
    end
  end
  
  def show
    @connection = Connection.find(params[:id])
  end

  def edit
    @connection = Connection.find(params[:id])
  end
  
  def update
    @connection = Connection.find(params[:id])
    unless @connection
      flash[:error] = 'No such connection to update.'
    else
      if @connection.update_attributes(params[:connection])
	flash[:notice] = 'Connection was successfully updated.'
      else
	render edit_connection_path(params[:id])
	return
      end
    end
    redirect_to connections_path
  end

  def destroy
    if (params[:id] == session[:connection])
      flash[:error] = "Can't delete active connection."
    else
      @connection = Connection.find(params[:id])
      unless @connection
	flash[:error] = 'No such connection to delete.'
      else
	unless @connection.destroy
	  flash[:error] = "Connection deletion failed"
	end
      end
    end
    redirect_to connections_path
  end
end
