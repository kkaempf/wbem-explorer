class InstancesController < ApplicationController
  require 'wbem'
  def index
    @class = params[:class]
    c = CimClass.find(@class)
    @title = "Instances of class #{c.name}"
    @ns = params[:ns] || "root/cimv2"
    @op = Sfcc::Cim::ObjectPath.new(@ns,c.name)
    url = session[:url]
    client = Wbem::Client.connect url
    @instances = client.instance_names(@op)
    @instances = Kaminari.paginate_array(@instances).page(params[:page]||1).per(20)
  end
  def show
  end
  def create
  end
  def update
  end
  def remove
  end
end
