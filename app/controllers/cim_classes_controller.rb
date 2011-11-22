class CimClassesController < ApplicationController
  respond_to :json, :html
  def index
    @model = params[:model]
    @mode = params[:mode] || "list"
    @cim_classes = CimClass.where(:cim_model_id => @model).order(:name).page params[:page]
  end
  
  def show
    if params[:id] =~ /\d+/
      @cim_class = CimClass.find(params[:id])
    else
      @cim_class = CimClass.find_by_name(params[:id])
    end
  end
end
