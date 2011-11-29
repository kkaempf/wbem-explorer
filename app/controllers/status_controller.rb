class StatusController < ApplicationController
  respond_to :json, :html
  def update
    puts "Status#update for #{params.inspect}"
    @status = params[:status]
    render :partial => "content"
  end
end
