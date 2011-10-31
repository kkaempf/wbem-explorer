module HomeHelper
  def subnav_for_home
    r = Array.new
    unless session[:user]
      r << { :name => "Login", :path => login_path }
    else
      r << { :name => "Logout", :path => logout_path }
    end
    unless session[:host]
      r << { :name => "Connect", :path => connect_path }
    else
      r << { :name => "Release", :path => release_path }
    end
    r
  end
end