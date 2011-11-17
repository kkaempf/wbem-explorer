$(function(){

  var w = 800,
      h = 600,
      fill = d3.scale.category20();

  var vis = d3.select("#viewport").append("svg:svg")
      .attr("width", w)
      .attr("height", h);

  var names = [];
  var nodes = [];
  var links = [];

  $('#classnames_data > div').each(function(index) {
    n = $(this).attr('id');
    parent = $(this).attr('parent');
    names[n] = nodes.length;
    console.log("Node " + names[n] + ": " + n + " -> " + parent);
    nodes.push({name: n, parent: parent});
  });
  console.log("Extracting links of " + nodes.length + " nodes");
  var i;
  for (i=0; i < nodes.length; i += 1) {
    node = nodes[i];
//    console.log("Node " + i + ": " + node.name + " -> " + node.parent);
    if (node.parent && names[node.parent]) {
      link = {source: names[node.name], target: names[node.parent], value: 5};
      console.log("Link " + links.length + ": " + link.source + " -> " + link.target);
      links.push(link);
    }
  }
  console.log(nodes.length + " nodes");
  console.log(links.length + " links");
  console.log("Available symbol types");
  var force = d3.layout.force()
    .charge(-120)
    .linkDistance(30)
    .nodes(nodes)
    .links(links)
    .size([w, h])
    .start();
    
  var link = vis.selectAll("line.link")
      .data(links)
      .enter().append("svg:line")
      .attr("class", "link")
      .style("stroke-width", 20)
      .attr("x1", function(d) { return d.source.x; })
      .attr("y1", function(d) { return d.source.y; })
      .attr("x2", function(d) { return d.target.x; })
      .attr("y2", function(d) { return d.target.y; });

  var node = vis.selectAll("circle.node")
      .data(nodes)
      .enter().append("svg:circle")
      .attr("class", "node")
      .attr("cx", function(d) { return d.x; })
      .attr("cy", function(d) { return d.y; })
      .attr("r", 10)
      .style("fill", fill(5))
      .call(force.drag);

  node.append("svg:text")
    .attr("class", "nodetext")
    .attr("dx", 12)
    .attr("dy", ".5em")
    .text(function(d) { return d.name; });

  force.on("tick", function() {
    link.attr("x1", function(d) { return d.source.x; })
        .attr("y1", function(d) { return d.source.y; })
        .attr("x2", function(d) { return d.target.x; })
        .attr("y2", function(d) { return d.target.y; });

    node.attr("cx", function(d) { return d.x; })
        .attr("cy", function(d) { return d.y; });
  });
	
});
