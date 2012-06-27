class NamespacesController < ApplicationController
  
  def index
    require "lib/connection"
    @connection = Connection.open(session[:client])
    @namespaces = @connection.namespaces.sort
  end
end
