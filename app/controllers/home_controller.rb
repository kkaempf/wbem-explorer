class HomeController < ApplicationController
  require "lib/wbem_client.rb"
  
  # initial view, builds up main window with
  # sub-windows for Host, Function, View and Detail
  def index
    if session[:url]
      client,options = WbemClient.connect session[:url]
      if client
	result = client.identify( options )
	if result
	  @identify = { :product_vendor => result.ProductVendor, :product_version => result.ProductVersion, :protocol_version => result.ProtocolVersion }
	else
	  @identify = { :error => "Can't identify #{session[:connection]}" }
	end
      end
    end
  end
end
