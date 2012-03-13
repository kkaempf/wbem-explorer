class StoragesController < ApplicationController
  
  def index
    require 'wbem'
    @conn = Connection.find(session[:connection])
    client = @conn.connect
    @storages = client.storages.sort
  end
end
