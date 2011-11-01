class HostsController < ApplicationController
  
  def _host2hash host
    { :id => host.id, :name => host.name, :fqdn => host.fqdn, :secure => host.secure, :port => host.port, :path => host.path }
  end

  def index
    @hosts = Host.paginate :per_page => 10, :page => 1
  end

  def find
    @hosts = Host.paginate :per_page => 10, :page => params[:page], :order => 'updated_at DESC'
  end

  def show
    @host = Host.find(params[:id])
  end

  def new
    @host = Host.new
  end

  def create
    @host = Host.new(params[:host])
    if @host.save
      flash[:notice] = 'Host was successfully created.'
      redirect_to hosts_path
    else
      render new_host_path
    end
  end

  def edit
    @host = Host.find(params[:id])
  end

  def update
    @host = Host.find(params[:id])
    unless @host
      flash[:error] = "No such host to update"
    else
      if @host.update_attributes(params[:host])
	flash[:notice] = 'Host was successfully updated.'
      else
	render edit_host_path(params[:id])
	return
      end
    end
    redirect_to host_path
  end

  def destroy
    @host = Host.find(params[:id])
    unless @host
      flash[:warning] = "No such host to delete"
    else
      unless @host.destroy
	flash[:error] = "Cannot delete host"
      end
    end
    redirect_to hosts_path
  end
  
end
