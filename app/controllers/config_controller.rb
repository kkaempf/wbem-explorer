#
# configuration controller
#
class ConfigController < ApplicationController
  require_dependency 'cimclasses'
  require_dependency 'features'
  require_dependency 'featureviews'
	
  helper :start

  # configure which properties to view for which class, depending on session[:host]
  def classview
    # check for host
    unless session[:host]
      redirect_to :controller => "start", :action => "index"
      return
    end
    @host = session[:host]
    
    # check for classid parameter
    classid = params[:classid]
    unless classid
      redirect_to :controller => "function", :action => "browse"
      return
    end
    
    # check if classid is a valid class
    @cimclass = Cimclass.find( classid )
    unless @cimclass
      redirect_to :controller => "function", :action => "browse"
      return
    end
  end
  
  def propertyview
    classid = params[:classid]
    # clean current view records
    begin
      Featureview.delete_all( [ "host_id = ? and cimclass_id = ?", @session[:host].id, classid ] )
      params.each { |k,v|
        next unless k =~ /^_prop_/
        fv = Featureview.create( :host_id => @session[:host].id, :cimclass_id => classid, :feature_id => v )
	fv.save
      }
      redirect_to :controller => "view", :action => "instances", :classid => classid
    rescue Exception => e
      STDERR.puts "propertyview failed"
      STDERR.puts e
      redirect_to :controller => "config", :action => "classview", :classid => classid
    end
  end

  def description
    @desc = "DESCRIPTION"
    name = params[:name]
    if name
        c = eval("WsCim::#{name}")
        @desc = c.description if c
    end
    render(:partial => "show_description", :layout => false)
  end

end
