class ViewController < ApplicationController
  require "wbem"
  require "cim"

  helper :start
  
  def instances
    classid = params[:classid]
    @cimclass = Cimclass.find( classid )
    unless @cimclass
        Rails.logger.debug "Class id #{classid} not found"
        redirect_to :controller => "function", :action => "browse"
	return
    end
    @host = session[:host]
    @features = Array.new
    featureviews = Featureview.find( :all, :conditions => [ "host_id = ? and cimclass_id = ?", @host.id, classid ] )
    if featureviews
      featureviews.each { |fview|
        feature = Feature.find( fview.feature_id )
	@features << feature.name if feature
      }
    end
    @client,@options = WsClient.create session[:client] unless @features.empty?
  end
  
  def hal
    halp = params[:hal]
    unless halp && halp.is_a?( Hash )
      redirect_to :controller => "function", :action => "hal"
      return
    end
    unless session[:client]
      flash[:alert] = "Please connect to a host first"
      redirect_to home_path
      return
    end
    @capability = halp[:capability]
    unless @capability
      @capability = params[:name]
    end
    @host = session[:host]
    @client,@options = WsClient.create session[:client]
  end

  def yast
    yastp = params[:yast]
    unless yastp && yastp.is_a?( Hash )
      redirect_to :controller => "function", :action => "yast"
      return
    end
    @ycp = yastp[:ycp]
    @host = session[:host]
    @client,@options = WsClient.create session[:client]
  end

end
