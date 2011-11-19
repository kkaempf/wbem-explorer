$(function(){

  var w = 800,
      h = 600,
      fill = d3.scale.category20();

  var vis = d3.select("#viewport").append("svg:svg")
      .attr("width", w)
      .attr("height", h);

  var names = [];
  var nodes = [];

  $('#classnames_data > div').each(function(index) {
    n = $(this).attr('id');
    parent = $(this).attr('parent');
    names[n] = nodes.length;
    console.log("Node " + names[n] + ": " + n + " -> " + parent);
    nodes.push({name: n, children: [], parent: parent});
  });
  console.log("Extracting children of " + nodes.length + " nodes");
  var i;
  for (i=0; i < nodes.length; i += 1) {
    var node = nodes[i];
    var node_id = names[node.name];
    var parent_id = names[node.parent];
    console.log("Node " + i + ": " + node.name + "("+node_id+") -> " + node.parent + "(" + parent_id + ")");
    if (parent_id !== undefined) {
      link = {source: names[node.name], target: names[node.parent], value: 5};
      console.log("Link " + links.length + ": " + link.source + " -> " + link.target);
      links.push(link);
    }
  }
  console.log(nodes.length + " nodes");
  console.log(links.length + " links");
  console.log("Available symbol types");
  var tree = d3.layout.tree()
    .nodes(nodes)
    .size([w, h])
    .start();

  var diagonal = d3.svg.diagonal()
    .projection(function(d) { return [d.y, d.x]; });

  var link = vis.selectAll("line.link")
      .data(tree.links(links))
      .enter().append("svg:line")
      .attr("class", "link")
      .style("stroke-width", 4)
      .attr("x1", function(d) { return d.source.x; })
      .attr("y1", function(d) { return d.source.y; })
      .attr("x2", function(d) { return d.target.x; })
      .attr("y2", function(d) { return d.target.y; });

  var node = vis.selectAll("rect.node")
      .data(nodes)
      .enter().append("svg:rect")
      .attr("class", "node")
      .attr("x", function(d) { return d.x; })
      .attr("y", function(d) { return d.y; })
      .attr("rx", 5)
      .attr("ry", 10)
      .attr("height", 25)
      .attr("width", function(d) { return d.name.length*0.8 + "em"; })
      .style("fill", "orange")
      .call(force.drag);

  var text = vis.selectAll("text.name")
    .data(nodes)
    .enter().append("svg:text")
    .attr("class", "name")
    .attr("x", function(d) { return d.x; })
    .attr("y", function(d) { return d.y; })
    .attr("dx", 12)
    .attr("dy", "1.5em")
    .style("fill", "black")
    .text(function(d) { return d.name; })
    .call(force.drag);

  force.on("tick", function() {
    link.attr("x1", function(d) { return d.source.x; })
        .attr("y1", function(d) { return d.source.y; })
        .attr("x2", function(d) { return d.target.x; })
        .attr("y2", function(d) { return d.target.y; });

    node.attr("x", function(d) { return d.x; })
        .attr("y", function(d) { return d.y; });
    text.attr("x", function(d) { return d.x; })
        .attr("y", function(d) { return d.y; });
  });
	
});
