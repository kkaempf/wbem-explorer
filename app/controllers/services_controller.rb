# enable sorting for Service endpoints
module Openwsman
  class EndPointReference
    def <=> epr
      self.to_s <=> epr.to_s
    end
  end
end

class ServicesController < ApplicationController
  
  def index
    _index "Services", services_path, :services, "No services found"
  end
end
