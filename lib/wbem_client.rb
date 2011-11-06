class WbemClient
  require 'uri'
  require 'wsman_client'
  require 'cimxml_client'
  def self.connect uri
    u = URI.parse uri
    case u.scheme
    when "wsman"
      u.scheme = "http"
      WsmanClient.connect u.to_s
    when "wsmans"
      u.scheme = "https"
      WsmanClient.connect u.to_s
    when "cimxml"
      u.scheme = "http"
      CimxmlClient.connect u.to_s
    when "cimxmls"
      u.scheme = "https"
      CimxmlClient.connect u.to_s
    else
      raise "Scheme #{u.scheme.inspect} for url #{uri} unsupported"
    end
  end
end
