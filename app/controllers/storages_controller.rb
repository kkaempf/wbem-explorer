class StoragesController < ApplicationController
  
  def index
    _index "Storage", storages_path, :storages, "No storage found"
  end
end
