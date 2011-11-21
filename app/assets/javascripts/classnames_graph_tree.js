$(function(){

  var names = [];
  var nodes = [];

  //
  // convert <li name="...">[<ul>...]
  // to { name: name, children: [...] }
  var node_to_tree = function(node) {
    var name = $(node).attr('name') || "root";
//    console.log("node_to_tree: ", node[0], "(", name, ")");
//    dump(node);
    var children = [];
    // $(node) is <div or <li, so use children() to get to the
    // <ul..<li inside
    $(node).children().children("ul > li").each(function(index) {
      var child;
      var ctag = this.tagName;
//      console.log(index + "=> " + name + " : " + ctag);
      child = node_to_tree(this);
      children.push(child);
    });
    var result = { name: name };
    if(children.length > 0) {
      result.children = children;
//      console.log("name: " + result.name + ", children: " + result.children);
    }
//    else {
//      console.log("name: " + result.name);
//    };
    return result;
  };

  var tree_to_console = function(node) {
    name = node.name;
    var s = "{ name: " + name;
    var i;
    if (node.children && node.children.length > 0) {
      s += ", children: [";
      i = 0;
      for (var c in node.children) {
        if (i > 0) {
	  s += ", ";
	}
	i += 1;
        s += tree_to_console(node.children[c]);
      }
      s += "]";
    }
    return s + " }";
  }
  var root = node_to_tree($('#classnames_data'));
  console.log("Root " + tree_to_console(root));

  var w = 800,
      h = 600;

  var vis = d3.select("#viewport").append("svg:svg")
      .attr("width", w)
      .attr("height", h)
      .append("svg:g")
      // shift 50px to right so root node doesn't get cut off
      .attr("transform", "translate(50,0)");

  var tree = d3.layout.tree()
    .size([w, h]);

  var n = tree.nodes(root);

  var diagonal = d3.svg.diagonal()
    .projection(function(d) { return [d.y, d.x]; });

  var link = vis.selectAll("path.link")
    .data(tree.links(n))
    .enter().append("svg:path")
    .attr("class", "link")
    .attr("d", diagonal);

  var node = vis.selectAll("g.node")
    .data(n)
    .enter().append("svg:g")
    .attr("class", "node")
    .attr("transform", function(d) { return "translate(" + d.y + "," + d.x + ")"; })
    
  node.append("svg:circle")
    .attr("r", 4.5);
    
  node.append("svg:text")
    .attr("dx", function(d) { return d.children ? -8 : 8; })
    .attr("dy", 3)
    .attr("text-anchor", function(d) { return d.children ? "end" : "start"; })
    .text(function(d) { return d.name; });
});
