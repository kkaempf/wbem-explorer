# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_ws-browser_session_id'
  
  layout 'main'
  helper :status
  
  require_dependency 'users'
  require_dependency 'hosts'

end
