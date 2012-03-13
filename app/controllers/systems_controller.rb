class SystemsController < ApplicationController
  
  def index
    require 'wbem'
    @conn = Connection.find(session[:connection])
    client = @conn.connect
    @systems = client.systems
  end
end
