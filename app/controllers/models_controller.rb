class ModelsController < ApplicationController
  
  def index
    if params[:mode] == "dynatree"
      render :partial => "dynatree"
      return
    else
      @models = CimModel.order(:name).page(params[:page])
    end
  end
end
