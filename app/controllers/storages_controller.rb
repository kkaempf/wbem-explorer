class StoragesController < ApplicationController
  
  def index
    @connection = Connection.open(session[:client])
    @names = @connection.storages.sort
    @names = Kaminari.paginate_array(@names).page(params[:page]||1).per(20)
  end
end
