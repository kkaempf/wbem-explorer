class ClassnamesController < ApplicationController
  respond_to :json, :html
  def index
    require 'wbem_client'
    puts "Classnames#index for #{params.inspect}"
    url = session[:url]
    c = WbemClient.connect url
    @classnames = Kaminari.paginate_array(c.classnames(params[:ns]).sort).page(params[:page]).per(20)
  end
end
