#!/usr/bin/env ruby

require 'pp'
require 'io/console'

def pause_program
  # print 'press any key'
  $stdin.getch
  puts
  # print "            \r"
end

FILE = 'input.txt'
ROW = 2000000

class Point
  attr_accessor :x, :y

  def initialize(x, y)
    self.x = x.to_i
    self.y = y.to_i
  end

  def mdistance(point)
    (self.x - point.x).abs + (self.y - point.y).abs
  end

  def area(op)
    # Return an array of Points that are mdistance or
    # less between this point and op.
    distance = self.mdistance(op)
    ps = []

    # This is inefficient as it scans points we know
    # are outside the manhattan distance but whatever
    if self.y - distance <= ROW && self.y + distance >= ROW
      for xidx in (self.x-distance..self.x+distance) do
        pnew = Point.new(xidx, ROW)
        # Skip the op in the list
        next if op == pnew
        ps.append(pnew) if self.mdistance(pnew) <= distance
      end
    end
    return ps.uniq
  end

  def ==(other)
    self.class == other.class &&
      self.x == other.x &&
      self.y == other.y
  end
end

SBPAIRS = []
PATTERN = /Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/
KNOWN = [] # These are all the points we know have or do not have a beacon

File.readlines(FILE).each_with_index do |line, idx|
  line.match(PATTERN) { |m| SBPAIRS.append([Point.new(m[1], m[2]), Point.new(m[3], m[4])]) }
end

#pp SBPAIRS
SBPAIRS.each do |pair|
  KNOWN.concat(pair[0].area(pair[1]))
end

pp KNOWN.uniq(&:x).size
