module HomeHelper
  def subnav_for_home
    if session[:connection]
      [ { :name => "Disconnect", :path => disconnect_connection_path } ]
    else
      [ { :name => "Connect", :path => connect_path } ]
    end
  end
end