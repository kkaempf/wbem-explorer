class HomeController < ApplicationController
  require "lib/wsclient.rb"
  require_dependency 'users'
  
  # initial view, builds up main window with
  # sub-windows for Host, Function, View and Detail
  def index
    if session[:user] && session[:host]
      unless session[:client]
	user = session[:user]
	
	h = session[:host]
	s = "http" + (h[:secure]?:"s":"") + "://"
	if user.login
	  s += user.login
	  if user.password
	    s += ":"
	    s += user.password
	  end
	  s += "@"
	end
	s += h[:fqdn]
	s += ":"
	s += h[:port].to_s
	s += h[:path]
	session[:client] = s
      end
      STDERR.puts "session[:client] #{session[:client]}"
      client,options = WsClient.create session[:client]
      if client
	result = client.identify( options )
	if result
	  @identify = { :product_vendor => result.product_vendor, :product_version => result.product_version, :protocol_version => result.protocol_version }
	else
	  user = session[:user]
	  name = user[:fullname]
	  name = user[:name] unless name && name.empty?
	  @identify = { :error => "Can't identify host #{session[:host][:name]} as user '#{user}'" }
	end
      end
    else
      session[:client] = nil
    end
  end

  def connect
    session[:connection] = params[:connection_id]
    redirect_to home_path
  end

  def disconnect
    session[:connection] = nil
    redirect_to home_path
  end

end
