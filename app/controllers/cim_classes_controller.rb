class CimClassesController < ApplicationController
  respond_to :json, :html
  
private
  # should probably go to the helper
  
  # get flat list of classes
  def get_class_list model
    if model
      return CimClass.where(:cim_model_id => model)
    else
      return CimClass.all
    end
  end

  # Extract children of name from classlist
  #
  def tree_children_of name, classlist
    children = []
    classlist.each do |c|
      if c.parent && c.parent.name == name
        children << c.name
      end
    end

    tree_sorted_children_of children, classlist
  end

  def tree_sorted_children_of parents, classlist
    result = nil
    parents.sort.each do |name|
      result ||= []
      children = tree_children_of(name, classlist)
      if children
        result << { :name => name, :children => children }
      else
        result << { :name => name }
      end
    end
    result
  end

  # Convert flat list of classes to d3.js 'tree' layout
  # return list (sorted by classname) of hashes
  # [{ :name => "parent", :children => [ { "child" : ... }, ... ]

  def convert_to_tree classlist
    # extract root names first
    roots = []   
    classlist.each do |c|
      next if c.parent
      roots << c.name
    end
    
    result = tree_sorted_children_of roots, classlist

    result
  end

  # Find all children of node and add them in 'force' layout to nodes and links
  def children_as_force name, group, nodes, links, classlist
    source = nodes.size
    nodes << { :name => name, :group => group }
    classlist.each do |c|
      if c.parent && c.parent.name == name
        target = nodes.size
        links << { :source => source, :target => target }
        children_as_force c.name, group, nodes, links, classlist
      end
    end
  end
  
  # Convert flat list of classes to d3.js 'force' layout
  # return hash of
  # { 
  #    :nodes => [ { :name => "name", :group => N }, ... ]
  #    :links => [ { :source => X, :target => Y, :value => Z }, ... ]
  # }
  # with :group == root class
  #
  def convert_to_force classlist
    # extract root names first
    nodes = []
    links = []
    group = 1
    classlist.each do |c|
      next if c.parent
      children_as_force c.name, group, nodes, links, classlist
#      break
      group += 1
    end
    { :nodes => nodes, :links => links }
    
  end

public
  #
  # Show many classes (of a model)
  # Either as flat list, tree, or graph (-> params[:mode])
  #
  def index
    @model = params[:model]
    @mode = params[:mode] || "list"
    @layout = params[:layout] # for 'graph' mode
    @title = "Classes"

    # graph mode gets the class list via Ajax from 'data'
    return if @mode == "graph"

    model = CimModel.find(@model) rescue nil
    @title << " for model '#{model.name}'" if model

    @cim_classes = get_class_list model

    @cim_classes = @cim_classes.order(:name).page(params[:page]) if @mode == "list"
    @cim_classes = convert_to_tree(@cim_classes) if @mode == "tree"
  end
  
  #
  # Show a single class
  #
  def show
    if params[:id] =~ /\d+/
      @cim_class = CimClass.find(params[:id])
    else
      @cim_class = CimClass.find_by_name(params[:id])
    end
  end
  
  # Ajax callback, retrieve classes as js
  # convert Array of classes to Tree hash
  def data
    model = params[:model]
    layout = params[:layout]
    case layout
    when "tree","indented"
      tree = convert_to_tree( get_class_list model ) # Array
      # d3.js tree layout expects a single object
      render :json => { :name => "", :children => tree }
    when "force"
      force = convert_to_force( get_class_list model ) # Hash
      STDERR.puts "Force #{force.inspect}"
      render :json => force
    else
      STDERR.puts "Unknown data layout '#{layout.inspect}'"
      render :nothing => true
    end
  end

end
