#!/usr/bin/env ruby

require 'pp'
require 'io/console'

def pause_program
  print 'press any key'
  $stdin.getch
  print "            \r"
end

HEAD = [0, 0]
TAIL = [0, 0]
VISITED = Hash.new

def record_tail_visit
  VISITED[TAIL.join(',')] = 1
end

def motion(direction, steps)
  (xdir, ydir) = offset(direction)
  s = 0
  while s < steps
    step(HEAD, xdir, ydir)
    # Does TAIL need to move?
    hor_delta = HEAD[0] - TAIL[0]
    ver_delta = HEAD[1] - TAIL[1]
    xdir_tail = 0
    ydir_tail = 0
    unless hor_delta.abs < 2 && ver_delta.abs < 2
      if hor_delta.abs == 2
        xdir_tail = hor_delta == 2 ? 1 : -1
        ydir_tail = ver_delta
      else
        xdir_tail = hor_delta
        ydir_tail = ver_delta == 2 ? 1 : -1
      end
      # Record place TAIL was
      record_tail_visit
      # Move TAIL to new place
      step(TAIL, xdir_tail, ydir_tail)
    end
    s += 1
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
  knot[0] = knot[0] + xdir
  knot[1] = knot[1] + ydir
end

File.readlines('input.txt').each do |line|
  line.chomp!
  (direction, steps) = line.split(' ')
  motion(direction, steps.to_i)
end

# Record the final resting place of TAIL
record_tail_visit

puts VISITED.keys.uniq.length
