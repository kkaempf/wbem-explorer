class NamespacesController < ApplicationController
  
  def index
    require 'wbem'
    url = session[:url]
    c = Wbem::Client.connect url
    @namespaces = c.namespaces.sort
  end
end
