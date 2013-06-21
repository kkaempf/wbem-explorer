class NetworksController < ApplicationController
  
  def index
    _index "Networks", networks_path, :networks, "No networks found"
  end
end
