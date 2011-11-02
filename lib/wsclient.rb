class WsClient
  require "openwsman"
  def self.create uri
#    WsMan::debug = -1
    client = Openwsman::Client.new uri
    if client
      client.transport.timeout = 5
      client.transport.auth_method = Openwsman::BASIC_AUTH_STR
	  
      options = Openwsman::ClientOptions.new
      return client,options
    end
    return nil
  end
end
