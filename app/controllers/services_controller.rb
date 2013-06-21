class ServicesController < ApplicationController
  
  def index
    @connection = Connection.open(session[:client])
    @title = "Services"
    @path = services_path
    begin
      @names = @connection.services
      @names = Kaminari.paginate_array(@names).page(params[:page]||1).per(20)
    rescue Sfcc::Cim::ErrorNotSupported
      session[:status] = "Operation not supported by CIMOM"
    rescue Exception => e
      session[:status] = "No services found: #{e.inspect}"
    end
    redirect_to home_path unless @names
  end
end
