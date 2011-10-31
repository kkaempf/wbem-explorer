module HostsHelper
  def subnav_for_hosts
    [
     { :name => "Add", :path => new_host_path },
     { :name => "List", :attributes => hosts_path },
     { :name => "Search", :attributes => search_host_path },
     { :name => "Connect", :attributes => connect_host_path }
    ]
  end
end
