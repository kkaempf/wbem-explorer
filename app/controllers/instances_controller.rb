class InstancesController < ApplicationController
  private

  # http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  def instance_params
    params.require(:instance).permit(:class, :epr)
  end

  public
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
    id = params[:id]
    if id == "_epr"
      @epr = Openwsman::EndPointReference.new(params[:epr])
      STDERR.puts "@epr >>#{@epr}<<"
      @connection = Connection.open(session[:client])
      @instance = @connection.get @epr
      STDERR.puts "@instance >>#{@instance}<<"
      if @instance
        @cim_class = CimClass.find_by(:name => @instance.classname)
        STDERR.puts "@cim_class >>#{@cim_class.inspect}<<"
        @ns = @epr.namespace
      end
    end
  end
  def create
  end
  def update
  end
  def remove
  end
end
