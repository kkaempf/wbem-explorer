class NamespacesController < ApplicationController
  require 'connection'
private
  def _refresh
    @client = Client.find(session[:client])
    existing = @client.namespaces
    Rails.logger.debug "namespaces/refresh #{@namespaces.inspect} for client #{@client}"
    if existing && !existing.empty?
      @client.namespaces = []
    end
    @connection = Connection.open(@client)
    Rails.logger.debug "namespaces/refresh connection #{@connection.class}"
    @connection.namespaces.sort.each do |name|
      Rails.logger.debug "Refresh namespace #{name}"
      namespace = Namespace.find_or_create_by_name name
      @client.namespaces << namespace
    end
  end
public
  def index
    @client = Client.find(session[:client])
    @namespaces = @client.namespaces
    if @namespaces.empty?
      _refresh
      @namespaces = @client.namespaces
    end
    Rails.logger.debug "namespaces #{@namespaces.inspect}"
  end

  def refresh
    _refresh
    redirect_to home_path
  end
end
