#
# Client is User+Host+Mode(cimxml/wsman) and one can establish a connection to it
#
class ClientsController < ApplicationController
  respond_to :html, :json

  private

  # http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  def client_params
    params.require(:client).permit(:name, :host, :login, :password, :protocol, :secure, :port, :path, :auth_scheme)
  end

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
    client = client_params()
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
      client = client_params()[:client] # get nested Hash
      client[:auth_scheme] = AuthScheme.find(client[:auth_scheme])
      if @client.update_attributes(client)
        Rails.logger.debug "GOOD"
	flash[:notice] = 'Client was successfully updated.'
      else
        Rails.logger.debug "BAD"
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
