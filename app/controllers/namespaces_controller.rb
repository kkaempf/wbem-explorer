class NamespacesController < ApplicationController
private
  def _refresh
    @client = Client.find(session[:client])
    existing = @client.namespaces
    if existing && !existing.empty?
      @client.namespaces = []
    end
    @connection = Connection.open(session[:client])
    @connection.namespaces.sort.each do |name|
      STDERR.puts "Refresh namespace #{name}"
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
  end

  def refresh
    _refresh
    redirect_to :index
  end
end
