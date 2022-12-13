#!/usr/bin/env ruby

require 'pp'
require 'io/console'

def pause_program
  # print 'press any key'
  $stdin.getch
  puts
  # print "            \r"
end

class Coord
  attr_accessor :row, :col

  def initialize(row, col)
    self.row = row
    self.col = col
  end

  def to_s
    "[#{self.row}, #{self.col}]"
  end
end

G = []
S = []
E = Coord.new(-1, -1)

def search(point, steps, visited)
  # Return if we've been on this spot before and our step count is higher
  # than what it was the last time we were here. It's not the shortest path.
  return visited if !visited[point.to_s].nil? && steps >= visited[point.to_s]

  visited[point.to_s] = steps
  current = G[point.row][point.col]
  return visited if current == 27 # We've reached E -- we're done!

  up = (point.col + 1 < G.first.size ? G[point.row][point.col + 1] : 30)
  down = (point.col - 1 >= 0 ? G[point.row][point.col - 1] : 30)
  left = (point.row - 1 >= 0 ? G[point.row - 1][point.col] : 30)
  right = (point.row + 1 < G.size ? G[point.row + 1][point.col] : 30)

  visited = search(Coord.new(point.row, point.col + 1), steps + 1, visited) if up - current < 2 || (current == 25 && up == 27)
  visited = search(Coord.new(point.row, point.col - 1), steps + 1, visited) if down - current < 2 || (current == 25 && down == 27)
  visited = search(Coord.new(point.row - 1, point.col), steps + 1, visited) if left - current < 2 || (current == 25 && left == 27)
  visited = search(Coord.new(point.row + 1, point.col), steps + 1, visited) if right - current < 2 || (current == 25 && right == 27)
  visited
end

row = 0
File.readlines('input.txt').each do |line|
  G[row] = line.chomp.chars.map { |x| x.ord - 96 }
  if G[row].include?(-13)
    # We no longer care about a specific start point
    # so just turn this into an 'a' elevation point.
    G[row][G[row].find_index(-13)] = 'a'.ord - 96
  end
  if G[row].include?(-27)
    E.row = row
    E.col = G[row].find_index(-27)
    G[row][E.col] = 27
  end
  # Note all the points in this row where the value is
  # 'a' and add them to the list we need to search.
  col = 0
  while col < G[row].size
    if G[row][col] == 'a'.ord - 96
      S.append(Coord.new(row, col))
    end
    col += 1
  end
  row += 1
end

minsteps = 481 # We know part one is 481 so it has to be less than that

puts "Checking #{S.size} starting points"

visited = {}

S.each do |s|
  search(s, 0, visited)
  if visited[E.to_s]
    puts "It takes at least #{visited[E.to_s]} steps from #{s} to #{E}"
    minsteps = visited[E.to_s] if visited[E.to_s] < minsteps
  end
end

puts minsteps
