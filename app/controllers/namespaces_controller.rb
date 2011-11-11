class NamespacesController < ApplicationController
  
  def index
    require 'wbem_client'
    url = session[:url]
    c = WbemClient.connect url
    @namespaces = c.namespaces
  end
end
