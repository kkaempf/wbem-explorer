#
# Client is User+Host+Mode(cimxml/wsman) and one can establish a connection to it
#
class ClientsController < ApplicationController
  respond_to :html, :json

  private

  public
  def index
    if params[:mode] == "dynatree"
      render :partial => "dynatree"
      return
    else
      @clients = Client.order(:name).page(params[:page])
    end
  end

  def new
    @client = Client.new
  end

  def create
    client = params[:client]
    client[:host] = Host.find(client[:host])
    client[:auth_scheme] = AuthScheme.find(client[:auth_scheme])
    @client = Client.new(client)
    if @client && @client.save
      flash[:notice] = 'Client was successfully created.'
      redirect_to clients_path
    else
      flash[:error] = 'Client creation failed.'
      redirect_to new_client_path
    end
  end
  
  def show
    @client = Client.find(params[:id])
  end

  def edit
    @client = Client.find(params[:id])
  end
  
  def update
    @client = Client.find(params[:id])
    unless @client
      flash[:error] = 'No such client to update.'
    else
      client = params[:client]
      client[:host] = Host.find(client[:host])
      client[:auth_scheme] = AuthScheme.find(client[:auth_scheme])
      if @client.update_attributes(params[:client])
	flash[:notice] = 'Client was successfully updated.'
      else
	render edit_client_path(params[:id])
	return
      end
    end
    redirect_to client_path
  end

  def destroy
    @client = Client.find(params[:id])
    unless @client
      flash[:error] = 'No such client to delete.'
    else
      unless @client.destroy
        flash[:error] = "Client deletion failed"
      end
    end
    redirect_to clients_path
  end
end
