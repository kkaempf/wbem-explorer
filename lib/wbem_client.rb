class WbemClient
  require 'uri'
  require 'wsman_client'
  require 'cimxml_client'
  
  attr_reader :url, :response

  def initialize url
    @url = (url.is_a? URI) ? url : URI.parse(url)
  end

  def response_code
    @client.response_code
  end

  def fault_string
    @client.fault_string
  end

  #
  # WbemClient.connect uri
  #

  def self.connect uri
    u = URI.parse uri
    return case u.scheme
    when "wsman"
      u.scheme = "http"
      WsmanClient.new u
    when "wsmans"
      u.scheme = "https"
      WsmanClient.new u
    when "cimxml"
      u.scheme = "http"
      CimxmlClient.new u
    when "cimxmls"
      u.scheme = "https"
      CimxmlClient.new u
    else
      raise "Scheme #{u.scheme.inspect} for url #{uri} unsupported"
    end
  end

end
