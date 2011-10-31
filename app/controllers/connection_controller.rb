class ConnectionController < ApplicationController
  def new
    session[:host] = nil
    id = params[:id]
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
  end

  def create
    host = session[:host]
    unless host
      # not called from connect, but from 'host input field'
      host = params[:host]
      name = host[:name]
      fqdn = host[:fqdn]
      if name
	host = Hosts.find_by_name( name )
      elsif fqdn
        host = Hosts.find_by_fqdn( fqdn )
      end
    end
    unless host
      flash[:alert] = 'Unknown host.'
      redirect_to new_connection_path
    else
#      session[:host] = _host2hash host
      session[:host] = host
      redirect_to home_path
    end
  end

  def destroy
    session[:host] = nil
    redirect_to home_path
  end
end
