class NamespacesController < ApplicationController
  
  def index
    require 'wbem'
    @conn = Connection.find(session[:connection])
    client = @conn.connect
    @namespaces = client.namespaces.sort
  end
end
