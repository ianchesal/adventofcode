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
MAX = 4000000

class Point
  attr_accessor :x, :y, :distance

  def initialize(x, y, bx, by)
    self.x = x.to_i
    self.y = y.to_i
    self.distance = (self.x - bx.to_i).abs + (self.y - by.to_i).abs
  end

  def in_range?(p)
    return ((self.x - p.x).abs + (self.y - p.y).abs) <= self.distance
  end

  def perimeter
    dy = [1,1,-1,-1]
    dx = [-1,1,1,-1]

    px = self.x
    py = self.y - (self.distance+1)

    (0..3).each do |i|
      (0..self.distance+1).each do |j|
        px += dx[i]
        py += dy[i]
        if px >= 0 && px <= MAX && py >= 0 && py <= MAX
          yield Point.new(px, py, 0, 0)
        end
      end
    end
  end
end

SENSORS = []
PATTERN = /Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/

File.readlines(FILE).each_with_index do |line, idx|
  line.match(PATTERN) { |m| SENSORS.append(Point.new(m[1], m[2], m[3], m[4])) }
end

# The point we're looking for has to occur just outside the perimeter of all
# of the circles that surround the sensor/beacon pairs. So rather than look
# at MAX^2 points, I'm going to look at all the points just beyond the
# manhattan distance of each sensor. That should be far fewer points.

SENSORS.each_with_index do |sone, idx|
  sone.perimeter do |p|
    puts "Sensor #{idx+1} of #{SENSORS.size}: (#{p.x}, #{p.y})"
    this_is_the_spot = true
    SENSORS.each do |s|
      if s.in_range?(p)
        this_is_the_spot = false
        break
      end
    end
    if this_is_the_spot
      puts "This is the spot: (#{p.x}, #{p.y})"
      puts (p.x * 4000000) + p.y
      exit
    end
  end
end

puts "...fuck"
