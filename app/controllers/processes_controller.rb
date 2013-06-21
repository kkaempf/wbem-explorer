class ProcessesController < ApplicationController
  
  def index
    _index "Processes", processes_path, :processes, "No processes found"
  end
end
