module HomeHelper
  def subnav_for_home
    if session[:connection]
      [ { :name => "Disconnect", :path => connection_disconnect_path(:connection_id => session[:connection]) } ]
    else
      [ { :name => "Connect", :path => connect_path } ]
    end
  end
end