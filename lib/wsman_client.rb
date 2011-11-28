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
  class ObjectPath
    attr_reader :namespace, :classname
    def initialize namespace, classname = nil
      @namespace = namespace
      @classname = classname
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

  def objectpath classname, namespace
    Openwsman::ObjectPath.new classname, namespace
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
    "Protocol: #{root.ProtocolVersion}, Vendor #{root.ProductVendor}, Version #{root.ProductVersion}"
  end
  
  def namespaces
    STDERR.puts "Namespaces client #{@client} with #{@options}"
    @options.flags = Openwsman::FLAG_ENUMERATION_OPTIMIZATION
    @options.max_elements = 999
    prefix = "http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/"
    ret = []
    ["CIM_Namespace", "__Namespace"].each do |cn|
      ['root/cimv2', 'Interop', 'interop', 'root', 'root/interop'].each do |ns|
	@options.cim_namespace = ns
        resource = prefix + cn
	STDERR.puts "Enumerate '#{@options.cim_namespace}: '#{resource}'"
	result = @client.enumerate( @options, nil, resource )
	next unless result
	STDERR.puts "Result '#{result.to_xml}'"
	result.body.EnumerateResponse.Items.each do |path|
	  ret << path.Name.to_s
	end rescue nil
      end
    end
    ret
  end

  def classnames namespace, deep_inheritance
    @options.flags = Openwsman::FLAG_ENUMERATION_OPTIMIZATION
    @options.max_elements = 999
    @options.cim_namespace = namespace
    method = Openwsman::CIM_ACTION_ENUMERATE_CLASS_NAMES
    uri = Openwsman::XML_NS_CIM_INTRINSIC
    result = @client.invoke( @options, uri, method )
    if result.fault?
      STDERR.puts "ENUMERATE_CLASS_NAMES unsupported"      
      return []
    end
    output = result.body[method]
    classes = []
    output.each do |c|
      classes << c.to_s
    end
    return classes
  end

  def instance_names object_path
    @options.flags = Openwsman::FLAG_ENUMERATION_OPTIMIZATION
    @options.max_elements = 999
    @options.cim_namespace = object_path.namespace
    # http://schemas.microsoft.com/wbem/wsman/1/wmi/root/cimv2/
    # CIM=http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2
    # OpenWBEM=http://schema.openwbem.org/wbem/wscim/1/cim-schema/2
    # Linux=http://sblim.sf.net/wbem/wscim/1/cim-schema/2
    # OMC=http://schema.omc-project.org/wbem/wscim/1/cim-schema/2
    # PG=http://schema.openpegasus.org/wbem/wscim/1/cim-schema/2
    uri = "http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/"+object_path.classname
    result = client.enumerate( @options, nil, uri )
    if result.fault?
      STDERR.puts "ENUMERATE_CLASS_NAMES unsupported"      
      return []
    end
    output = result.body[method]
    instances = []
    output.each do |i|
      instances << i.to_s
    end
    return instances
  end
end
