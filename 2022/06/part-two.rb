#!/usr/bin/env ruby

require 'pp'
require 'io/console'

def pause_program
  print "press any key"
  STDIN.getch
  print "            \r"
end

File.readlines('input.txt').each do |line|
  stream = line.chomp.split('')
  # Find the start of the first unique 14-element array within stream
  i = 0
  found = false
  while !found
    found = true if stream[i,14].uniq.length == 14
    i += 1
  end
  puts i+13
end

