class ClassnamesController < ApplicationController
  respond_to :json, :html
  def index
    require 'wbem_client'
    puts "Classnames#index for #{params.inspect}"
    url = session[:url]
    c = WbemClient.connect url
    @ns = params[:ns]
    @mode = params[:mode] || "list"
    @conn = Connection.find(session[:connection])
    @title = "#{@conn.name}: Class names for namespace #{@ns}"
    # Use Kaminari pagination with an array
    @classnames = c.classnames(@ns, true).sort
    if @mode == "list"
      @classnames = Kaminari.paginate_array(@classnames).page(params[:page]).per(20)
    end
  end
end
