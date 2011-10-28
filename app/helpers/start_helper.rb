module StartHelper
  def subnav_for_start
    r = Array.new
    unless session[:user]
      r << { :name => "Login", :attributes => { :controller => :user, :action => :login } }
    else
      r << { :name => "Logout", :attributes => { :controller => :user, :action => :logout } }
    end
    unless session[:host]
      r << { :name => "Connect", :attributes => { :controller => :host, :action => :connect } }
    else
      r << { :name => "Release", :attributes => { :controller => :host, :action => :release } }
    end
    r
  end
end