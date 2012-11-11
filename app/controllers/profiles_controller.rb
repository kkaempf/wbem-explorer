class ProfilesController < ApplicationController
  
  def index
    puts "Profiles#index for #{session.inspect}"
  end
end
