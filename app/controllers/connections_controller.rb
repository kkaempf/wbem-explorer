class ConnectionsController < ApplicationController
  respond_to :html, :json

  private
  def _disconnect
    session[:connection] = nil
    session[:url] = nil
  end

  public
  def connect
    require 'wbem_client'
    id = params[:connection_id]
    begin
      connection = Connection.find(id)
      unless connection
	flash[:error] = "Connect failed: no such connection"
	raise
      end

      _disconnect

      url = connection.to_uri
      begin
	c = WbemClient.connect url
	begin
	  flash[:notice] = c.identify
	  session[:connection] = id
	  session[:url] = url
	rescue AuthError
	  flash[:error] = "Wrong credentials for #{connection}"
	  raise
	rescue Exception => e
	  flash[:error] = "Cannot access #{connection}: #{e.class} #{e}"
	  raise
	end
      rescue Exception => e
	flash[:error] = "Connect failed: #{e}"
	raise
      end
    rescue Exception => e
      STDERR.puts "Connection.connect: #{e}"
      flash[:error] = "Oops: #{e}"
    end
    if params[:mode] == "dynatree"
      respond_with({:data => connection.to_s})      # triggers Ajax 'success' function
    else
      redirect_to request.referer
    end
  end

  def disconnect
    _disconnect
    redirect_to home_path
  end

  def index
    if params[:mode] == "dynatree"
      @connections = Connection.all
      render :partial => "dynatree"
      return
    else
      @connections = Connection.paginate :per_page => 10, :page => 1
    end
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
