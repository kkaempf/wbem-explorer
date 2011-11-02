class HomeController < ApplicationController
  require "lib/wsclient.rb"
  
  # initial view, builds up main window with
  # sub-windows for Host, Function, View and Detail
  def index
    if session[:url]
      client,options = WsClient.create session[:url]
      if client
	result = client.identify( options )
	if result
	  @identify = { :product_vendor => result.ProductVendor, :product_version => result.ProductVersion, :protocol_version => result.ProtocolVersion }
	else
	  @identify = { :error => "Can't identify #{session[:connection]}" }
	end
      end
    end
  end

  def connect
    id = params[:connection_id]
    connection = Connection.find(id)
    unless connection
      flash[:error] = "Connect failed: no such connection"
    else
      host = Host.find(connection.host_id)
      user = User.find(connection.user_id)
      s = "http" + (connection.secure? ? "s" : "") + "://"
      if user.login
	s += user.login
	if user.password
	  s += ":"
	  s += user.password
	end
	s += "@"
      end
      s += host.fqdn
      s += ":"
      s += connection.port.to_s
      s += connection.path
      session[:connection] = id
      session[:url] = s
      STDERR.puts "session[:url] #{s}"
    end
    redirect_to home_path
  end

  def disconnect
    session[:connection] = nil
    session[:url] = nil
    redirect_to home_path
  end

end
