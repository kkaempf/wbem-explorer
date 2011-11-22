class CimClassesController < ApplicationController
  respond_to :json, :html
  def index
    @model = params[:model]
    @mode = params[:mode] || "list"
    @cim_classes = CimClass.order(:name).page(params[:page], :where => { :model => @model })
  end
end
