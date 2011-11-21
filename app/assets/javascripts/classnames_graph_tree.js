$(function(){

  var dump = function(obj) {
    console.log("dump("+obj+")");
    if (obj.value) {
      console.log("  " + obj.value);
    } 
    else {
    for (var i in obj) {
      console.log("  " + i + ": " + obj[i]);
    }
    }
  }
  var names = [];
  var nodes = [];

  //
  // convert <li name="...">[<ul>...]
  // to { name: name, children: [...] }
  var node_to_tree = function(node) {
    console.log("node_to_tree: ", node[0]);
//    dump(node);
    var children = [];
    $(node).children().each(function(index) {
      var name = $(this).attr('name') || "root";
      var child;
      var ctag = this.tagName;
      console.log(index + "=> " + name + " : " + ctag);
      child = node_to_tree(this);
      children.push(child);
    });
    var result = { name: name };
    if(children.length > 0) {
      result.children = children;
      console.log("name: " + result.name + ", children: " + result.children);
    }
    else {
      console.log("name: " + result.name);
    };
    return result;
  };

  var tree_to_console = function(node) {
    name = node.name;
    var s = "{ name: " + name;
    if (node.children && node.children.length > 0) {
      s += ", children: [";
      for (var c in node.children) {
        s += tree_to_console(node.children[c]);
	s += ", ";
      }
      s += "]";
    }
    return s;
  }
  console.log("Looking for #classnames_data");
  var root = node_to_tree($('#classnames_data'));
  console.log("Root " + tree_to_console(root));

  var w = 800,
      h = 600,
      fill = d3.scale.category20();

  var vis = d3.select("#viewport").append("svg:svg")
      .attr("width", w)
      .attr("height", h)
      .append("svg:g")
      .attr("class", "container");

  var tree = d3.layout.tree()
    .size([w, h]);

  var n = tree.nodes(root);
  var l = tree.links(nodes);

  var diagonal = d3.svg.diagonal()
    .projection(function(d) { return [d.y, d.x]; });
	
});
