class HostsController < ApplicationController
  
  def _host2hash host
    { :id => host.id, :name => host.name, :fqdn => host.fqdn, :secure => host.secure, :port => host.port, :path => host.path }
  end

  def index
    @hosts = Hosts.paginate :per_page => 10, :page => 1
  end

  def find
    @hosts = Hosts.paginate :per_page => 10, :page => params[:page], :order => 'updated_at DESC'
  end

  def show
    @host = Hosts.find(params[:id])
  end

  def new
    @host = Hosts.new
  end

  def create
    @host = Hosts.new(params[:host])
    if @host.save
      flash[:notice] = 'Host was successfully created.'
      redirect_to hosts_path
    else
      render new_host_path
    end
  end

  def edit
    @host = Hosts.find(params[:id])
  end

  def update
    @host = Hosts.find(params[:id])
    if @host.update_attributes(params[:host])
      flash[:notice] = 'Host was successfully updated.'
      redirect_to host_path(@host)
    else
      render edit_host_path(params[:id])
    end
  end

  def destroy
    host = Hosts.find(params[:id])
    unless host.destroy
      flash[:error] = "No such host to delete"
    end      
    redirect_to hosts_path
  end
  
end
