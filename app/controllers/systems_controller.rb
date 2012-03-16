class SystemsController < ApplicationController
  
  def index
    require 'wbem'
    @conn = Connection.find(session[:connection])
    client = @conn.connect
    @title = "ComputerSystem"
    @path = systems_path
    @names = client.systems
    @names = Kaminari.paginate_array(@names).page(params[:page]||1).per(20)
  end
end
