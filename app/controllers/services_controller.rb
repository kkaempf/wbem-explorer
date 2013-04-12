class ServicesController < ApplicationController
  
  def index
    @connection = Connection.open(session[:client])
    @title = "Services"
    @path = services_path
    @names = @connection.services
    @names = Kaminari.paginate_array(@names).page(params[:page]||1).per(20)
  end
end
