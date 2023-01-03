#!/usr/bin/env ruby

require 'pp'
require 'io/console'

def pause_program
  # print 'press any key'
  $stdin.getch
  puts
  # print "            \r"
end

FILE = 'sample.txt'
TICKS = 30

class Node
  attr_accessor :rate, :unvisited, :opened, :visited

  def initialize(rate, out)
    self.rate = rate.to_i
    self.opened = false
    self.visited = []
    self.unvisited = out
  end

  def has_unvisited?
    self.unvisited.size.positive?
  end

  def biggest_unvisited_child

  end
end

nodes = {}

PATTERN = /Valve (\S{2}) has flow rate=(\d+); tunnels lead to valves (.*)/

File.readlines(FILE).each_with_index do |line, idx|
  line.match(PATTERN) do |m|
    nodes[m[1]] = { rate: m[2].to_i, out: m[3].split(', ') }
  end
end

def move_node(curr)
  # Go to the next node with the highest flow rate
  n = nodes[curr][:out][0]
  r = nodes[n][:rate]
  (1..nodes[curr][:out].size - 1).each do |idx|
    if nodes[curr[:out][idx]][:rate] > r
      n = nodes[curr][:out][idx]
      r = nodes[n][:rate]
    end
  end
  n
end

flowing = []
visited = {}
total = 0
tick = 1
node = 'AA'

while tick <= TICKS
  # Move
  total += flowing.sum
  node = move_node(curr)
  tick += 1
  total += flowing.sum
  # Open valve
  flowing.append(nodes[node][:rate])

end
