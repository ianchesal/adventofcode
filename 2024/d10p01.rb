#!/usr/bin/env ruby

require 'io/console'

map = []
trailheads = {}

def continue_execution
  print 'press any key'
  $stdin.getch
  puts ''
end

def score(trailhead, map)
  # North
  visit([trailhead[0] - 1, trailhead[1]], 0, map) +
    # East
    visit([trailhead[0], trailhead[1] + 1], 0, map) +
    # South
    visit([trailhead[0] + 1, trailhead[1]], 0, map) +
    # West
    visit([trailhead[0], trailhead[1] - 1], 0, map)
end

def visit(coord, sum, map)
  return sum if coord[0].negative? || coord[0] >= map.length || coord[1].negative? || coord[1] >= map[0].length

  sum + 1 if map[coord[0]][coord[1]] == 9
end

File.readlines(ARGV[0], chomp: true).each do |line|
  map.append(line.split('').map(&:to_i))
end

pp map

# Catalog the trailheads and score them
map.each_with_index do |row, i|
  row.each_with_index do |spot, j|
    next unless spot.zero?

    trailheads[[i, j]] = {
      score: score([i, j], map)
    }
  end
end

# Add up the scores
sum = 0

trailheads.each do |th|
  sum += th[:score]
end

pp sum
