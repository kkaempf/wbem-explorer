class ServicesController < ApplicationController
  
  def index
    require 'wbem'
    @conn = Connection.find(session[:connection])
    client = @conn.connect
    @names = client.services
    @names = Kaminari.paginate_array(@names).page(params[:page]||1).per(20)
  end
end
