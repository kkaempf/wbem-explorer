class HostsController < ApplicationController
  
  def _host2hash host
    { :id => host.id, :name => host.name, :fqdn => host.fqdn, :secure => host.secure, :port => host.port, :path => host.path }
  end

  def index
    list
    render :action => 'list'
  end

  def list
    @hosts = Hosts.paginate :per_page => 10, :page => 1
  end

  def find
    @hosts = Hosts.paginate :per_page => 10, :page => params[:page], :order => 'updated_at DESC'
  end

  def show
    @host = Hosts.find(params[:id])
  end

  def add
    @host = Hosts.new
  end

  def create
    @host = Hosts.new(params[:host])
    if @host.save
      flash[:notice] = 'Host was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'create'
    end
  end

  def edit
    @host = Hosts.find(params[:id])
  end

  def update
    @host = Hosts.find(params[:id])
    if @host.update_attributes(params[:host])
      flash[:notice] = 'Host was successfully updated.'
      redirect_to :action => 'show', :id => @host
    else
      render :action => 'edit'
    end
  end

  def destroy
    Hosts.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def connect
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
  
  def verifyconnect
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
      redirect_to :action => 'connect'
    else
#      session[:host] = _host2hash host
      session[:host] = host
      redirect_to home_path
    end
  end
  
  def release
    session[:host] = nil
    redirect_to home_path
  end
end
