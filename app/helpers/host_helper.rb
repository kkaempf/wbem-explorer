module HostHelper
  def subnav_for_hosts
    [
     { :name => "Add", :attributes => { :action => "add" } },
     { :name => "List", :attributes => { :action => "list" } },
     { :name => "Search", :attributes => { :action => "search" } },
     { :name => "Connect", :attributes => { :action => "connect" } }
    ]
  end
end
