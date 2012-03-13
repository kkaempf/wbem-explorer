class ProcessesController < ApplicationController
  
  def index
    require 'wbem'
    @conn = Connection.find(session[:connection])
    client = @conn.connect
    @processes = client.processes
  end
end
