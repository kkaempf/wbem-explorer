module HostsHelper
  def subnav_for_hosts
    [
     { :name => "New", :path => new_host_path },
     { :name => "List", :path => hosts_path },
     { :name => "Search", :path => search_host_path }
    ]
  end
end
