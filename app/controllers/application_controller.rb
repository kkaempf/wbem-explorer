class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'main'
  helper :status
  
end
