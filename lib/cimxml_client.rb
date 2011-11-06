class CimxmlClient < WbemClient
  require "sfcc"

  def initialize uri
    super uri
    @client = Sfcc::Cim::Client.connect uri
  end
  
  #
  # identify client
  # return identification string
  # on error return nil and set @response to http response code
  #
  def identify
    @namespaces = []
    ["CIM_Namespace", "__Namespace"].each do |cn|
      ['root/cimv2', 'Interop', 'interop', 'root', 'root/interop'].each do |ns|
	op = Sfcc::Cim::ObjectPath.new(ns, cn)
	@client.instance_names(op).each do |path|
	  @namespaces << path.Name
	end
      end
    end
    if @namespaces.empty?
      return nil
    end
    "CIM/XML client at #{@uri.host}:#{@uri.port}"
  end
end
