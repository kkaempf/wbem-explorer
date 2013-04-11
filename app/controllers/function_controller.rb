class FunctionController < ApplicationController
  require "wbem"
  require "cim"

  def _ensure_client
    if session[:client] && session[:host]
#      @client, @options = WsClient.create session[:client]
      true
    else
      redirect_to home_path
      false
    end
  end

  def _connect
  end
  
  # Inventory
  def inventory
    return unless _ensure_client
  end
  
  # Status
  def status
    return unless _ensure_client
  end
  
  # Browse
  def browse
    name = params[:name]
    return unless name   # select class first

    host = session[:host]
    unless host
      redirect_to home_path
      return
    end

    # we have a class
    @cimclass = Cimclass.find_by_name( name )
    unless @cimclass
      @cimclass = Cimclass.create( :name => name )
      @cimclass.save
    end
    
    # now check if the host/class is already configured
    featureview = Featureview.find( :first, :conditions => [ "host_id = ? AND cimclass_id = ?", host.id, @cimclass.id ] )
    
    if featureview
      return unless _ensure_client # select user/host first
      # view instances
      redirect_to :controller => "view", :action => "instances", :classid => @cimclass.id
    else
      # config host/class
      redirect_to :controller => "config", :action => "classview", :classid => @cimclass.id
    end

  end
  
  # Ajax callback from CIM class prefix selector
  #  the interesting paramter is passed as a key to params[]
  #  so we need to filter it out
  #  (it starts with uppercase and ends with underscore)
  def prefix
    p = nil
    params.each { |k,v|
      if (k[-1,1] == "_") && (k[0,1] =~ /[A-Z]/)
	p = k
	break
      end
    }
    all_classes = WsCim::constants
    if p == "CIM_"
      @classes = all_classes.reject { |c| c =~ /_/ }
    elsif p
      @classes = all_classes.grep( Regexp.new( "^#{p}" ) )
    end
    @classes.sort!
    render(:partial => "browse_class_prefix", :layout => false)
  end
  
  # Hal
  def hal
  end
  
  # YaST
  def yast
  end

end
