#!/usr/bin/env ruby

require 'pp'
require 'io/console'

def pause_program
  print 'press any key'
  $stdin.getch
  print "            \r"
end

FOREST = []

col = 0

File.readlines('input.txt').each do |line|
  line.chomp!
  FOREST[col] = line.chars.map(&:to_i)
  col += 1
end

def viewing_distance(col, row)
  left(col, row) * right(col, row) * up(col, row) * down(col, row)
end

def left(col, row)
  distance = 0
  ir = row - 1
  while ir >= 0
    distance += 1
    break if FOREST[col][ir] >= FOREST[col][row]

    ir -= 1
  end
  distance
end

def right(col, row)
  distance = 0
  ir = row + 1
  while ir < FOREST[col].length
    distance += 1
    break if FOREST[col][ir] >= FOREST[col][row]

    ir += 1
  end
  distance
end

def up(col, row)
  distance = 0
  ic = col - 1
  while ic >= 0
    distance += 1
    break if FOREST[ic][row] >= FOREST[col][row]

    ic -= 1
  end
  distance
end

def down(col, row)
  distance = 0
  ic = col + 1
  while ic < FOREST.length
    distance += 1
    break if FOREST[ic][row] >= FOREST[col][row]

    ic += 1
  end
  distance
end

best_distance = 0

col = 0
while col < FOREST.length
  row = 0
  while row < FOREST[col].length
    d = viewing_distance(col, row)
    if d > best_distance
      best_distance = d
    end
    row += 1
  end
  col += 1
end

puts best_distance
