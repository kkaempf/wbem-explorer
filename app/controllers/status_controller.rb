class StatusController < ApplicationController
  respond_to :json, :html
  # Updating the 'status' box
  def update
    Rails.logger.debug "Status#update for #{params.inspect}"
    @status = params[:status]
    render :partial => "content"
  end
  # Ajax callback to get connection status
  def connected
    Rails.logger.debug "Status#status session[:client] #{session[:client].inspect}"
    render :json => (session[:client] != nil)
  end
end
