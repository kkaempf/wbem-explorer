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
  
  #
  # Return list of namespaces
  #
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
  
  #
  # Return list of classnames for given namespace
  #
  def classnames namespace
    STDERR.puts "#{@client}.classnames(#{namespace})"
    ret = []
    op = Sfcc::Cim::ObjectPath.new(namespace)
    flags = Sfcc::Flags::DeepInheritance
    begin
      @client.class_names(op,flags).each do |name|
	ret << name.to_s
      end
    rescue Sfcc::Cim::ErrorInvalidNamespace
    end
    ret
  end
end
