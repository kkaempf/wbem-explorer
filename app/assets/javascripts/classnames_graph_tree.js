$(function(){

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

  var data = node_to_tree($('#classnames_data'));

  var r = 600 / 2;

  var tree = d3.layout.tree()
    .size([360, r])
    .separation(function(a, b) { return (a.parent == b.parent ? 1 : 2) / a.depth; });

  var nodes = tree.nodes(data);

  var diagonal = d3.svg.diagonal.radial()
    .projection(function(d) { return [d.y, d.x / 180 * Math.PI]; });

  var vis = d3.select("#viewport").append("svg:svg")
      .attr("width", r * 2 + r/2)
      .attr("height", r * 2)
      .append("svg:g")
      // shift 150px to right so root node doesn't get cut off
      .attr("transform", "translate("+(r+150)+","+r+")");

  nodes = $.map(nodes, function(n,i) { return (n.name == "root" ? null : n); });

  var link = vis.selectAll("path.link")
    .data(tree.links(nodes))
    .enter().append("svg:path")
    .attr("class", "link")
    .attr("d", diagonal);

  var node = vis.selectAll("circle.node")
    .data(nodes)
    .enter().append("svg:circle")
    .attr("class", "node")
    .attr("r", 4.5)
    // this rotates the complete group (circle + text)
    .attr("transform", function(d) { return "rotate(" + (d.x - 90) + ")translate(" + d.y + ")"; });

  var text = vis.selectAll("text.name")
    .data(nodes)
    .enter().append("svg:text")
    .attr("class", "name")
    .attr("dx", function(d) { return d.x < 180 ? 8 : -8; })
    .attr("dy", ".31em")
    .attr("text-anchor", function(d) { return d.x < 180 ? "start" : "end"; })
    // transform/rotate text within group
    .attr("transform", function(d) {
//       console.log(d.name + "@x:" + d.x + ",y:" + d.y);
       return "rotate(" + (d.x-90) + ")translate(" + d.y + ")rotate("+(70-d.x)+")";
    })
    .text(function(d) { return d.name; });

  $( "#slider-vertical" ).slider({
    orientation: "vertical",
    range: "min",
    min: 0,
    max: 360,
    value: 70,
    slide: function( event, ui ) {
//      var e = ui.getEventTargetType(event);
      var value = $( "#slider-vertical" ).slider("value" );
      vis.selectAll("text.name")
      .attr("transform", function(d) {
        return "rotate(" + (d.x-90) + ")translate(" + d.y + ")rotate("+(value-d.x)+")";
      });
    }
  });
});
