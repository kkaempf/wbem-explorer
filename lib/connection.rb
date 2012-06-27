require "client"
require "wbem"

class Connection
  attr_reader :client

  def to_s
    "Connection to #{@client}"
  end

  def initialize client
    if client.is_a Client
      @client = client
    else
      @client = Client.find(client)
    end
    begin
      @connection = Wbem::Client.connect @client.to_uri, @client.protocol, @client.auth_scheme
    rescue Exception => e
      STDERR.puts "Wbem::Client.connect(#{@client.to_uri}, #{@client.protocol}, #{@client.auth_scheme}) failed with #{e}"
      raise
    end
    raise "Connection to #{@client} failed" unless @connection
  end
end
