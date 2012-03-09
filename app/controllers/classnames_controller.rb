class ClassnamesController < ApplicationController
private
  # Convert flat list of classes to d3.js 'tree' layout
  # return list (sorted by classname) of hashes
  # [{ :name => "parent", :children => [ { "child" : ... }, ... ]

  def convert_to_tree classlist
    # extract root names first
    result = []   
    classlist.each do |c|
      result << { :name => c }
    end
    
    result
  end

  def convert_to_force classlist
    nodes = []
    links = []
    # extract root names first
    classlist.each do |c|
      nodes << { :name => c }
    end
    
    { :nodes => nodes, :links => links }
  end
public

  def index
    require 'wbem'
    puts "Classnames#index for #{params.inspect}"
    @ns = params[:ns]
    @mode = params[:mode] || "list"
    @layout = params[:layout] # if mode == graph
    @controller = "classnames"
    @conn = Connection.find(session[:connection])
    client = @conn.connect
    @title = "#{@conn.name}: Class names for namespace #{@ns}"
    # retrieve with deep_inheritance
    @classes = client.class_names(@ns).sort
    # Use Kaminari pagination with an array
    @classes = Kaminari.paginate_array(@classes).page(params[:page]).per(20) if @mode == "list"
    @classes = convert_to_tree(@classes) if @mode == "tree"
  end

  # Ajax callback, retrieve classes as js
  # convert Array of classes to Tree hash
  def data
    ns = params[:ns]
    layout = params[:layout]
    @conn = Connection.find(session[:connection])
    client = @conn.connect
    @classes = client.class_names(ns).sort
    case layout
    when "tree","indented"
      tree = convert_to_tree( @classes) # Array
      # d3.js tree layout expects a single object
      render :json => { :name => "", :children => tree }
    when "force"
      force = convert_to_force( @classes ) # Hash
      STDERR.puts "Force #{force.inspect}"
      render :json => force
    else
      STDERR.puts "Unknown data layout '#{layout.inspect}'"
      render :nothing => true
    end
  end

end

