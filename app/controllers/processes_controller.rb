class ProcessesController < ApplicationController
  
  def index
    require 'wbem'
    @conn = Connection.find(session[:connection])
    client = @conn.connect
    @names = client.processes
    @names = Kaminari.paginate_array(@names).page(params[:page]||1).per(20)
  end
end
