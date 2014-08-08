#!/usr/bin/env ruby
require 'graph'

def truncate(the_string)
  #Set the maximum amount of characters to appear in a node
  # #LEVEL: node_character_limit = 22
  node_character_limit = 30
  return the_string unless the_string.length > node_character_limit
  return the_string[0..node_character_limit] + "..."
end

unless ARGV[0]
  puts "usage: ruby #{$0} <data file, pipe separated>"
  exit -1
end

nodenames = {}

#Set the margin of a node.  Default is "1", whatever that means. .5 is good for a non-fixed size.
margin = "0.05"
#Set height.  A good height for fixedsize=true is ".3", a good height for not is ".05"
height = ".3"
#Set width, only use if using fixedsize=true.  2.4 is good for a character limit of 30
# #LEVEL: width = "3.25"
width = "4.5"
#Set distance between node rows.
nodesep = "0.05"
#Set distance between tiers
ranksep = "0.3"

#Force boxes to all be the same size
fixedsize = true

digraph do

  # Set the font name and size.  Details here:  http://www.graphviz.org/doc/fontfaq.txt
  # Set font for non-ubuntu
  #the_font = font "Times-Roman"
  # Set font for ubuntu, smh...
  the_font = font "Times New Roman,"

  # Set the font size, since we're scaling to 6.5" width, we had to increase the font size.  Will give us more pixels anyway, so it's a good thing
  the_fontsize = fontsize "22"
  # set box color
  the_color = color "blueviolet"

  graph_attribs << "splines=polyline" << 'labeljust="l"' << "nojustify=true"
  graph_attribs << "ranksep=#{ranksep}" if defined? ranksep
  graph_attribs << "nodesep=#{nodesep}" if defined? nodesep
  edge_attribs << 'headport="w"' << 'tailport="e"'
  node_attribs << the_fontsize << the_font << the_color
  node_attribs << "height=#{height}" if defined? height
  node_attribs << "width=#{width}" if defined? width
  node_attribs << "fixedsize=#{fixedsize}" if defined? fixedsize
  node_attribs << "margin=#{margin}" if defined? margin

  # Orientation.  Defaults "TB" (top to bottom), alternate "LR" (left to right)
  orient "LR"
  
  # Set node shape
  node_attribs << box

  # Read file
  f = File.open(ARGV[0], "r")
  f.each_line do |line|
    line = line.split("|")
    current =  line[0]
    base =  line[0].gsub(/\.[^.]+$/,"");
    base = base.to_s

    # Contents of each node
    nodenames[current] = truncate("#{current} #{line[1].strip}")
    ## For two lines...
    # nodenames[current] = truncate("#{current} #{line[1].strip}") + "\n" + truncate("#{line[2].strip}")

    # These two lines create a "node" object, then assign a label.  The \\l will left justify things, \\r for right, take it off for center
    curr_node = node nodenames[current];
    curr_node.label(nodenames[current]+"\\l");

    if current != base
      curr_edge = edge nodenames[base], nodenames[current]
    end
  end

  save ARGV[0], 'png'
end

