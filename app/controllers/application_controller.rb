class ApplicationController < ActionController::Base
  protect_from_forgery
  layout "wbem_explorer"
  helper :status
  
end
