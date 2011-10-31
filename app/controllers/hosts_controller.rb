class HostsController < ApplicationController
  helper :start
  
  def _host2hash host
    { :id => host.id, :name => host.name, :fqdn => host.fqdn, :secure => host.secure, :port => host.port, :path => host.path }
  end

  def index
    list
    render :action => 'list'
  end

  def list
    @host_pages, @hosts = paginate :hosts, :per_page => 10
  end

  def show
    @host = Host.find(params[:id])
  end

  def add
    @host = Host.new
  end

  def create
    @host = Host.new(params[:host])
    if @host.save
      flash[:notice] = 'Host was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'create'
    end
  end

  def edit
    @host = Host.find(params[:id])
  end

  def update
    @host = Host.find(params[:id])
    if @host.update_attributes(params[:host])
      flash[:notice] = 'Host was successfully updated.'
      redirect_to :action => 'show', :id => @host
    else
      render :action => 'edit'
    end
  end

  def destroy
    Host.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def connect
    session[:host] = nil
    id = params[:id]
    if (id)
      host = Host.find(id)
      if host
#	session[:host] = _host2hash host
	session[:host] = host
	redirect_to :controller => "start", :action => "index"
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
	host = Host.find_by_name( name )
      elsif fqdn
        host = Host.find_by_fqdn( fqdn )
      end
    end
    unless host
      flash[:alert] = 'Unknown host.'
      redirect_to :action => 'connect'
    else
#      session[:host] = _host2hash host
      session[:host] = host
      redirect_to :controller => "start", :action => "index"
    end
  end
  
  def release
    session[:host] = nil
    redirect_to :controller => "start", :action => "index"
  end
end
