class StatusController < ApplicationController
  respond_to :json, :html
  # Updating the 'status' box
  def update
    puts "Status#update for #{params.inspect}"
    @status = params[:status]
    render :partial => "content"
  end
  # Ajax callback to get connection status
  def connected
    puts "Status#status"
    render :json => (session[:connection] != nil)
  end
end
