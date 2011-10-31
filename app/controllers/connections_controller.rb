class ConnectionsController < ApplicationController
  def new
    session[:host] = nil
    id = params[:id]
    STDERR.puts "ConnectionsController#new #{params.inspect}"
    if (id)
      host = Hosts.find(id)
      if host
#	session[:host] = _host2hash host
	session[:host] = host
	redirect_to home_path
      else
	flash[:notice] = "Host unknown"
      end
    end
    redirect_to home_path
  end

  def destroy
    session[:host] = nil
    redirect_to home_path
  end
end
