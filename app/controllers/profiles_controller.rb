class ProfilesController < ApplicationController
  
  def index
    _index "RegisteredProfiles", profiles_path, :profiles, "No registered profiles found"
  end
end
