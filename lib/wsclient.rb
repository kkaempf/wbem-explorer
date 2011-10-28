class WsClient
  require "rwsman"
  def self.create uri
#    WsMan::debug = -1
    client = WsMan::Client.new uri
    if client
      client.transport.timeout = 5
      options = WsMan::ClientOption.new
      return client,options
    end
    return nil
  end
end
