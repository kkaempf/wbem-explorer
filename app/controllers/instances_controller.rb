class InstancesController < ApplicationController
  require "lib/connection"
  def index
    @class = params[:class]
    klass = CimClass.find(@class)
    @title = "Instances of class #{klass.name}"
    @ns = params[:ns] || "root/cimv2"
    @connection = Connection.open(session[:client])
    @instances = @connection.instance_names(@ns,klass.name)
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
