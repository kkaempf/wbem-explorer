class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'main'
  helper :status
  
  require_dependency 'users'
  require_dependency 'hosts'
end
