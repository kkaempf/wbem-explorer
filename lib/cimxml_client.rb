class CimxmlClient < WbemClient
  require "sfcc"

  def initialize url
    super url
    @client = Sfcc::Cim::Client.connect url
  end
  
  #
  # identify client
  # return identification string
  # on error return nil and set @response to http response code
  #
  def identify
    "CIM/XML client at #{@url.host}:#{@url.port}"
  end
  
  def namespaces
    ret = []
    ["CIM_Namespace", "__Namespace"].each do |cn|
      ['root/cimv2', 'Interop', 'interop', 'root', 'root/interop'].each do |ns|
	op = Sfcc::Cim::ObjectPath.new(ns, cn)
	begin
	  @client.instance_names(op).each do |path|
	    ret << path.Name
	  end
	rescue Sfcc::Cim::ErrorInvalidClass, Sfcc::Cim::ErrorInvalidNamespace
	end
      end
    end
    ret
  end
end
