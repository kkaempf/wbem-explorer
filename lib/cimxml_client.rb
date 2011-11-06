class CimxmlClient
  require "sfcc"
  def self.connect uri
    client = Sfcc::Cim::Client.connect uri
    op = Sfcc::Cim::ObjectPath.new("root/cimv2", "")
    return client,op
  end
end
