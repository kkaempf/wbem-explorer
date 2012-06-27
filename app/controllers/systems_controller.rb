class SystemsController < ApplicationController
  
  def index
    require "lib/connection"
    @connection = Connection.open(session[:client])
    @title = "ComputerSystem"
    @path = systems_path
    @names = @connection.systems
    @names = Kaminari.paginate_array(@names).page(params[:page]||1).per(20)
  end
end
