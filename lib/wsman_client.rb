require "openwsman"

class AuthError < StandardError
end

module Openwsman
  class Transport
    def Transport.auth_request_callback( client, auth_type )
      STDERR.puts "\t *** Transport.auth_request_callback"
      return nil
    end
  end
end

class WsmanClient < WbemClient
  def initialize uri
    Openwsman::debug = -1
    STDERR.puts "\n\t*** WsmanClient #{uri}\n"
    @client = Openwsman::Client.new uri.to_s
    raise "Cannot create Openwsman client" unless @client
    @client.transport.timeout = 5
    @client.transport.auth_method = Openwsman::BASIC_AUTH_STR
    
    @options = Openwsman::ClientOptions.new
	
  end

  def identify
    STDERR.puts "Identify client #{@client} with #{@options}"
    doc = @client.identify( @options )
    unless doc
      raise AuthError
    end
    if doc.fault?
      fault = doc.fault
      STDERR.puts "Fault: #{fault.to_xml}"
      raise fault.to_s
    end
    root = doc.root
    prot_version = root.ProtocolVersion
    prod_vendor = root.ProductVendor
    prod_version = root.ProductVersion		    
  end
end
