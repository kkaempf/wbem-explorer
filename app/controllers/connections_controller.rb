class ConnectionsController < ApplicationController
  respond_to :html, :json

  public
  def create
    require "lib/connection"

    id = params[:client]
    begin
      client = Client.find(id)
      unless client
	flash[:error] = "Connect failed: no such client"
	raise
      end

      destroy

      begin
	begin
          @connection = Connection.open client
	  flash[:notice] = @connection.product
	  session[:client] = id
	rescue Exception => e
	  flash[:error] = "Cannot access #{client}: #{e.class} #{e}"
          session[:status] = e.to_s
	end
      rescue Exception => e
	flash[:error] = "Connect to #{client} failed: #{e}"
        session[:status] = e.to_s
      end
    rescue Exception => e
      STDERR.puts "Connection.create(#{client}): #{e}"
      flash[:error] = "Oops: #{e}"
      session[:status] = e.to_s
    end
    if params[:mode] == "dynatree"
      if @connection
        respond_with({:data => (@connection.to_s + "[#{@connection.product}]") })      # triggers Ajax 'success' function
      else
        respond_with({:data => flash[:error]})      # triggers Ajax 'success' function
      end
    else
      redirect_to request.referer
    end
  end

  def destroy
    session[:client] = nil
    session[:status] = nil
  end

end
