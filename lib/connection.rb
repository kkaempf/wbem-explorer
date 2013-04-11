require "client"
require "wbem"

class Connection
  attr_reader :client

  def self.open client
    if client.is_a? Client
      client = client
    else
      client = Client.find(client)
    end
    begin
      connection = Wbem::Client.connect client.to_uri, client.protocol, client.auth_scheme
    rescue Exception => e
      Rails.logger.debug "Wbem::Client.connect(#{client.to_uri}, #{client.protocol}, #{client.auth_scheme}) failed with #{e}"
    end
    raise "Connection to #{@client} failed" unless connection
    connection
  end
end
