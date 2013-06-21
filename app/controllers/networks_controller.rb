class NetworksController < ApplicationController
  
  def index
    @connection = Connection.open(session[:client])
    @title = "Networks"
    @path = networks_path
    begin
      @names = @connection.networks
      @names = Kaminari.paginate_array(@names).page(params[:page]||1).per(20)
    rescue Sfcc::Cim::ErrorNotSupported
      session[:status] = "Operation not supported by CIMOM"
    rescue Exception => e
      session[:status] = "No network found: #{e.inspect}"
    end
    redirect_to home_path unless @names
  end
end
