#!/usr/bin/env ruby

require 'pp'
require 'io/console'

def pause_program
  # print 'press any key'
  $stdin.getch
  puts
  # print "            \r"
end

packets = []
File.readlines('input.txt').each_with_index do |line, idx|
  next if (idx + 1) % 3 == 0
  line.chomp!
  line.gsub!('[]', '[0]') # Sadly, I'm not entirely certain why this works
  packets.append(eval(line))
end
packets.append([[2]])
packets.append([[6]])
packets = packets.sort_by(&:flatten) # Friggin' Ruby magic some times...
puts (packets.index([[2]]) + 1) * (packets.index([[6]]) + 1)
