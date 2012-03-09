class InstancesController < ApplicationController
  require 'wbem'
  def index
    @class = params[:class]
    klass = CimClass.find(@class)
    @title = "Instances of class #{klass.name}"
    @ns = params[:ns] || "root/cimv2"
    @op = Sfcc::Cim::ObjectPath.new(@ns,klass.name)
    @conn = Connection.find(session[:connection])
    client = @conn.connect
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
