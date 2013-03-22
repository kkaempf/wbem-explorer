class ConnectionsController < ApplicationController
private
  def disconnect
    session[:client] = nil
    session[:status] = nil
  end
public
  def create
    require "lib/connection"

    id = params[:client]
    begin
      @client = Client.find(id)
      STDERR.puts "Connection.create(#{id}) => #{@client}"
      unless @client
	flash[:error] = "Connect failed: no such client"
	raise
      end

      disconnect

      begin
        @connection = Connection.open @client
        STDERR.puts "Connection.open(#{@client}) => #{@connection}"
        flash[:notice] = @connection.product
        session[:client] = id
      rescue Exception => e
        flash[:error] = "Cannot access #{client}: #{e.class} #{e}"
        session[:status] = e.to_s
      end
    rescue Exception => e
      flash[:error] = "Client #{id} not found: #{e}"
      session[:status] = e.to_s
    end
    unless @connection
      @error = flash[:error] # make error available in view
    end
  end

  def destroy
    disconnect
    redirect_to home_path
  end

end
