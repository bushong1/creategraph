#!/usr/bin/env ruby
require 'graph'

unless ARGV[0]
  puts "usage: ruby #{$0} <data file, pipe separated>"
  exit -1
end
nodenames = {}

node_character_limit = 30
weight = 0
digraph do
  
  # Set the font name and size.  Details here:  http://www.graphviz.org/doc/fontfaq.txt
  the_font = font "Times"
  #the_font = font "Helvetica"
  the_fontsize = fontsize "10"
  # set box color
  the_color = color "blueviolet"
  node_attribs << the_fontsize << the_font << the_color

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
    nodenames[current] = "" + current+" "+line[1].strip

    # Truncate
    if nodenames[current].length > node_character_limit
      #To only do for level 3+, count the dots like this:  if current.count(".") >= 2
      nodenames[current] = nodenames[current][0..node_character_limit] + "..."
    end
    if current != base
      curr_edge = edge nodenames[base], nodenames[current]
      #Tried messing with line weight (aka, length) but it isn't working
      #if (current.count(".") == 2) 
      #  weight = weight +1;
      #  curr_edge.attributes << "weight=#{(weight % 3) * 5+5}."
      #end
    end
  end

  save ARGV[0], 'png'
end
