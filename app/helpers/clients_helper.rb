module ClientsHelper
  def subnav_for_clients
    [
     { :name => "New", :path => new_client_path },
     { :name => "List", :path => Clients_path },
     { :name => "Search", :path => search_client_path }
    ]
  end
end
