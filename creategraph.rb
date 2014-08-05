#!/usr/bin/env ruby
require 'graph'

unless ARGV[0]
  puts "usage: ruby #{$0} <data file, pipe separated>"
  exit -1
end
nodenames = {};
digraph do
  test = font "Helvetica-Bold"
  node_attribs << test
  test = fontsize "8"
  node_attribs << test
  color "blue"
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
  orient "LR"
  node_attribs << box

  save 'languages', 'png'
end
