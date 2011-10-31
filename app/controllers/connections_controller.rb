class ConnectionsController < ApplicationController
  def index
    @connections = Connections.paginate :per_page => 10, :page => 1
  end

  def find
    @hosts = Hosts.paginate :per_page => 10, :page => params[:page], :order => 'updated_at DESC'
  end

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

  def create
  end
  
  def edit
  end
  
  def update
  end

  def destroy
    session[:host] = nil
    redirect_to home_path
  end
end
