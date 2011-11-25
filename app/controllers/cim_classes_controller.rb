class CimClassesController < ApplicationController
  respond_to :json, :html
  def index
    model = params[:model]
    @model = CimModel.find(model) rescue nil
    @mode = params[:mode] || "list"
    @title = "Classes"
    @cim_classes = CimClass
    if @model
      @title << " for model '#{@model.name}'" if @model
      @cim_classes = @cim_classes.where(:cim_model_id => model)
    end
    @cim_classes = @cim_classes.order(:name)
    if @mode == "list"
      @cim_classes = @cim_classes.page params[:page]
    end
  end
  
  def show
    if params[:id] =~ /\d+/
      @cim_class = CimClass.find(params[:id])
    else
      @cim_class = CimClass.find_by_name(params[:id])
    end
  end
end
