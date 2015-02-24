class ApplicationController < ActionController::Base
  protect_from_forgery
  layout "wbem_explorer"
  require 'connection'

  def _index title, path, function, errmsg
    @connection = Connection.open(session[:client])
    @title = title
    @path = path
    begin
      @names = @connection.send function
      @names = Kaminari.paginate_array(@names.sort).page(params[:page]||1).per(20)
    rescue Sfcc::Cim::ErrorNotSupported
      flash[:notice] = "Operation not supported by CIMOM"
      redirect_to home_path
    rescue Exception => e
      flash[:error] = "#{errmsg}: #{e.inspect}"
      redirect_to home_path
    end
  end

end
