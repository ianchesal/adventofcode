#!/usr/bin/env ruby

require 'pp'
require 'io/console'

def pause_program
  # print 'press any key'
  $stdin.getch
  puts
  # print "            \r"
end

CYCLE = 1
REGISTER = 1
CRT = []

def draw_pixel
  if (CRT.length % 40).between?(REGISTER - 1, REGISTER + 1)
    CRT.append('#')
  else
    CRT.append('.')
  end
end

File.readlines('input.txt').each do |line|
  line.chomp!
  if line == 'noop'
    CYCLE += 1
    draw_pixel
  else
    v = line.split(' ')[1].to_i
    CYCLE += 1
    draw_pixel
    CYCLE += 1
    draw_pixel
    REGISTER += v
  end
end

(0..CRT.length - 1).each do |i|
  print "\n" if (i % 40).zero?
  print CRT[i]
end
print "\n"
