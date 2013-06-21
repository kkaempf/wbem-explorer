class SystemsController < ApplicationController
  
  def index
    _index "ComputerSystem", systems_path, :systems, "No systems found"
  end
end
