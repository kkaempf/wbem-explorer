class NetworksController < ApplicationController
  
  def index
    require 'wbem'
    @conn = Connection.find(session[:connection])
    client = @conn.connect
    @networks = client.networks
  end
end
