class NetworksController < ApplicationController
  
  def index
    @connection = Connection.open(session[:client])
    @names = @connection.networks
    @names = Kaminari.paginate_array(@names).page(params[:page]||1).per(20)
  end
end
