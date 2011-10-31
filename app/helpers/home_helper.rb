module HomeHelper
  def subnav_for_home
    r = Array.new
    unless session[:user]
      r << { :name => "Login", :path => login_user_path }
    else
      r << { :name => "Logout", :path => logout_user_path }
    end
    unless session[:host]
      r << { :name => "Connect", :path => connect_host_path }
    else
      r << { :name => "Release", :path => release_host_path }
    end
    r
  end
end