class ClassnamesController < ApplicationController
  respond_to :json, :html
  def index
    require 'wbem'
    puts "Classnames#index for #{params.inspect}"
    url = session[:url]
    c = Wbem::Client.connect url
    @ns = params[:ns]
    @mode = params[:mode] || "list"
    @conn = Connection.find(session[:connection])
    @title = "#{@conn.name}: Class names for namespace #{@ns}"
    # retrieve with deep_inheritance
    @classnames = c.class_names(@ns, true).sort
    if @mode == "list"
      # Use Kaminari pagination with an array
      @classnames = Kaminari.paginate_array(@classnames).page(params[:page]).per(20)
    end
  end
end
