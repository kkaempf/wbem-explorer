class ProcessesController < ApplicationController
  
  def index
    require 'lib/connection'
    @connection = Connection.open(session[:client])
    @names = @connection.processes
    @names = Kaminari.paginate_array(@names).page(params[:page]||1).per(20)
  end
end
