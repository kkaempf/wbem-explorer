class ProfilesController < ApplicationController
  
  def index
    Rails.logger.debug "Profiles#index for #{session.inspect}"
  end
end
