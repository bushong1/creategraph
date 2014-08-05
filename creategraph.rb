#!/usr/bin/env ruby
require 'graph'

unless ARGV[0]
  puts "usage: ruby #{$0} <data file, pipe separated>"
  exit -1
end
nodenames = {};
digraph do
  
  # Set the font name and size.  Details here:  http://www.graphviz.org/doc/fontfaq.txt
  the_font = font "Helvetica-Bold"
  the_fontsize = fontsize "12"
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
    nodenames[current] = "" + current+" "+line[1].to_s
    if current != base
      edge nodenames[base], nodenames[current]
    end
  end

  save ARGV[0], 'png'
end
