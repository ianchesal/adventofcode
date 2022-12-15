#!/usr/bin/env ruby

require 'pp'
require 'io/console'

def pause_program
  # print 'press any key'
  $stdin.getch
  puts
  # print "            \r"
end

ROCKS = Hash.new
SAND = Hash.new

MIN_COL = 500
MAX_COL = 500
MAX_HEIGHT = 0

def abyss?(col, row)
  return true if col < MIN_COL
  return true if col > MAX_COL
  return true if row > MAX_HEIGHT
  false # We're still on the grid
end

def expand_rocks(s, e)
  return (s[1]..e[1]).map { |x| [s[0], x] } if s[1] < e[1]
  return (e[1]..s[1]).map { |x| [s[0], x] } if s[1] > e[1]
  return (s[0]..e[0]).map { |x| [x, s[1]] } if s[0] < e[0]
  (e[0]..s[0]).map { |x| [x, s[1]] }
end

def occupied?(col, row)
  point = "#{col},#{row}"
  ROCKS[point] || SAND[point]
end

def drop_sand(col, row)
  # Have I gone into the abyss?
  return [col, row] if abyss?(col, row)
  # Can I fall straight down?
  return drop_sand(col, row+1) if !occupied?(col, row+1)
  # Can I go down-left?
  return drop_sand(col-1, row+1) if !occupied?(col-1, row+1)
  # Can I go down-right?
  return drop_sand(col+1, row+1) if !occupied?(col+1, row+1)
  # I guess I stay right here!
  return [col, row]
end

File.readlines('input.txt').each_with_index do |line, idx|
  coords = line.split(' -> ')
  cpair = []
  coords.each do |c|
    (col, row) = c.split(',').map(&:to_i)
    MIN_COL = col if col < MIN_COL
    MAX_COL = col if col > MAX_COL
    MAX_HEIGHT = row if row > MAX_HEIGHT
    cpair.push([col, row])
    if cpair.size == 2
      expand_rocks(cpair.shift, cpair[0]).each { |p| ROCKS["#{p[0]},#{p[1]}"] = true }
    end
  end
end

while true
  (col, row) = drop_sand(500, 0)
  break if abyss?(col, row)
  SAND["#{col},#{row}"] = true
end

puts
puts SAND.keys.size
