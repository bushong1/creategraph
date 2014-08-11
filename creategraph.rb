#!/usr/bin/env ruby
require 'graph'

def truncate(the_string)
  #Set the maximum amount of characters to appear in a node
  # #LEVEL: node_character_limit = 22
  node_character_limit = 90
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
nodesep = "0.1"
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
  #the_color = color "#dddddc"

  graph_attribs << "splines=polyline"
  graph_attribs << 'labeljust="l"' << "nojustify=true"
  graph_attribs << "ranksep=#{ranksep}" if defined? ranksep
  graph_attribs << "nodesep=#{nodesep}" if defined? nodesep
  #graph_attribs << 'bgcolor="#dddddc"'

  edge_attribs << 'headport="w"' << 'tailport="e"' << 'color="#663399"'

  node_attribs << the_fontsize << the_font << 'color="#dddddc"' << 'fillcolor="#dddddc"' << 'style=filled'
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
    if(line[1].strip.length > 0 && (line[0].count('.') < 2 || (!line[2].nil? && line[2].strip.length > 0)))
      current =  line[0]
      base =  line[0].gsub(/\.[^.]+$/,"");
      base = base.to_s

      # Contents of each node
      if current.count('.') < 2
        unless line[2].nil?
          nodenames[current] = truncate("#{current} #{line[1].strip}") + "\\l" + truncate("#{line[2].strip}")
        else
          nodenames[current] = truncate("#{current} #{line[1].strip}")
        end
      else 
        #if defined? line[2] && line[2] != nil
        unless line[2].nil?
          nodenames[current] = "#{current} #{line[1].strip}\\l#{line[2].strip}"
        else
          nodenames[current] = "#{current} #{line[1].strip}"
        end
      end

      # These two lines create a "node" object, then assign a label.  The \\l will left justify things, \\r for right, take it off for center
      curr_node = node nodenames[current];

#      if current.count('.') == 1
#        split_label = nodenames[current].split(" ")
#        split_label[0] = "<B>#{split_label[0]}</B>"
#        join_label = split_label.join(" ")
#        curr_node.label("< #{join_label}\\\\l >");
#      else
      curr_node.label(nodenames[current]+"\\l");
#      end
      if current.count('.') >= 2
        # Change the width as needed
        curr_node.attributes << "width=20" << "height=0.7" #<< "fixedsize=false"
      else
        # Change the width as needed
        curr_node.attributes << "width=10" << "height=0.3" #<< "fixedsize=false"
      end
      if current.count('.') == 0
        curr_node.attributes << 'fillcolor="#663399"' << 'color="#663399"' << 'fontcolor=white'
      end

      if current != base
        curr_edge = edge nodenames[base], nodenames[current]
      end
    end
  end

  save ARGV[0], 'svg'
  save ARGV[0], 'png'
end

