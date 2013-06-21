class ServicesController < ApplicationController
  
  def index
    _index "Services", services_path, :services, "No services found"
  end
end
