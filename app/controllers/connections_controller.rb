class ConnectionsController < ApplicationController
  respond_to :html, :json

  private
  def _disconnect
    session[:connection] = nil
    session[:url] = nil
  end

  public
  def connect
    require 'wbem'
    id = params[:connection_id]
    client = nil
    begin
      connection = Connection.find(id)
      unless connection
	flash[:error] = "Connect failed: no such connection"
	raise
      end

      _disconnect

      begin
	client = connection.connect
	begin
	  flash[:notice] = client.product
	  session[:connection] = id
	  session[:url] = connection.to_uri
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
      if session[:connection]
        respond_with({:data => (connection.to_s + "[#{client.product}]") })      # triggers Ajax 'success' function
      else
        respond_with({:data => flash[:error]})      # triggers Ajax 'success' function
      end
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
      render :partial => "dynatree"
      return
    else
      @connections = Connection.order(:name).page(params[:page])
    end
  end

  def new
    session[:connection] = nil
    @connection = Connection.new
  end

  def create
    conn = params[:connection]
    conn[:host] = Host.find(conn[:host])
    conn[:auth_scheme] = AuthScheme.find(conn[:auth_scheme])
    @connection = Connection.new(conn)
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
      conn = params[:connection]
      conn[:host] = Host.find(conn[:host])
      conn[:auth_scheme] = AuthScheme.find(conn[:auth_scheme])
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
