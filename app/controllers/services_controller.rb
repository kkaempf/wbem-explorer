class ServicesController < ApplicationController
  
  def index
    require 'wbem'
    @conn = Connection.find(session[:connection])
    client = @conn.connect
    @services = client.services
  end
end
