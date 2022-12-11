#!/usr/bin/env ruby

require 'pp'
require 'io/console'

def pause_program
  print 'press any key'
  $stdin.getch
  print "            \r"
end

# 0 is head and 9 is tail now
KNOTS = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]]

VISITED = Hash.new

def record_tail_visit
  VISITED[KNOTS[9].join(',')] = 1
end


def motion(direction, steps)
  puts "Moving: #{direction} #{steps}"
  (0..steps - 1).each do |s|
    ki = 0

    (xdir, ydir) = offset(direction)
    step(KNOTS[ki], xdir, ydir)

    # Now check every other knot
    ki += 1
    while ki < KNOTS.length
      xdir = KNOTS[ki - 1][0] - KNOTS[ki][0]
      ydir = KNOTS[ki - 1][1] - KNOTS[ki][1]

      unless xdir.abs < 2 && ydir.abs < 2
        if xdir.abs == 2
          xdir = xdir == 2 ? 1 : -1
        end

        if ydir.abs == 2
          ydir = ydir == 2 ? 1 : -1
        end

        # Record place TAIL was if we're about to move the tail
        record_tail_visit if ki == 9
        step(KNOTS[ki], xdir, ydir)
      end

      ki += 1
    end
  end
end

def offset(direction)
  xdir = 0
  ydir = 0
  case direction
  when 'R'
    xdir = 1
  when 'L'
    xdir = -1
  when 'U'
    ydir = 1
  when 'D'
    ydir = -1
  else
    puts "Error: Unrecognized direction #{direction}"
    exit 1
  end
  [xdir, ydir]
end

def step(knot, xdir, ydir)
  knot[0] += xdir
  knot[1] += ydir
end

File.readlines('input.txt').each do |line|
  line.chomp!
  (direction, steps) = line.split(' ')
  motion(direction, steps.to_i)
end

# Record the final resting place of TAIL
record_tail_visit

puts VISITED.keys.uniq.length
