class WsClient
  require "openwsman"
  def self.create uri
#    WsMan::debug = -1
    client = Openwsman::Client.new uri
    if client
      client.transport.timeout = 5
      options = Openwsman::ClientOption.new
      return client,options
    end
    return nil
  end
end
