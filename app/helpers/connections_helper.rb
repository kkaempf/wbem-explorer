module ConnectionsHelper
  def subnav_for_connections
    [
     { :name => "New", :path => new_connection_path },
     { :name => "List", :path => connections_path },
     { :name => "Search", :path => search_connection_path }
    ]
  end
end
