class ApplicationController < ActionController::Base
  protect_from_forgery
  layout "wbem_explorer"
  
  def _index title, path, function, errmsg
    @connection = Connection.open(session[:client])
    @title = title
    @path = path
    begin
      @names = @connection.send function
      @names = Kaminari.paginate_array(@names.sort).page(params[:page]||1).per(20)
    rescue Sfcc::Cim::ErrorNotSupported
      flash[:notice] = "Operation not supported by CIMOM"
    rescue Exception => e
      flash[:error] = "#{errmsg}: #{e.inspect}"
    end
    redirect_to home_path unless @names
  end

end
