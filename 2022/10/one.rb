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
SIGNALS = []

def sample
  case CYCLE
  when 20
    SIGNALS.push(CYCLE * REGISTER)
  when 60
    SIGNALS.push(CYCLE * REGISTER)
  when 100
    SIGNALS.push(CYCLE * REGISTER)
  when 140
    SIGNALS.push(CYCLE * REGISTER)
  when 180
    SIGNALS.push(CYCLE * REGISTER)
  when 220
    SIGNALS.push(CYCLE * REGISTER)
  end
end

File.readlines('input.txt').each do |line|
  line.chomp!
  if line == 'noop'
    CYCLE += 1
  else
    v = line.split(' ')[1].to_i
    CYCLE += 1
    sample
    CYCLE += 1
    REGISTER += v
  end
  sample
end

puts SIGNALS.sum
