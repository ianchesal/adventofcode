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

def visible?(col, row)
  return true if col.zero?
  return true if col == FOREST.length - 1
  return true if row.zero?
  return true if row == FOREST[col].length - 1
  return true if check_left(col, row)
  return true if check_right(col, row)
  return true if check_up(col, row)
  return true if check_down(col, row)

  false
end

def check_left(col, row)
  ir = row - 1
  while ir >= 0
    return false if FOREST[col][ir] >= FOREST[col][row]

    ir -= 1
  end
  true
end

def check_right(col, row)
  ir = row + 1
  while ir < FOREST[col].length
    return false if FOREST[col][ir] >= FOREST[col][row]

    ir += 1
  end
  true
end

def check_up(col, row)
  ic = col - 1
  while ic >= 0
    return false if FOREST[ic][row] >= FOREST[col][row]

    ic -= 1
  end
  true
end

def check_down(col, row)
  ic = col + 1
  while ic < FOREST.length
    return false if FOREST[ic][row] >= FOREST[col][row]

    ic += 1
  end
  true
end

visible = 0

col = 0
while col < FOREST.length
  row = 0
  while row < FOREST[col].length
    r = visible?(col, row)
    visible += 1 if r
    row += 1
  end
  col += 1
end

puts visible
