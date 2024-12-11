#!/usr/bin/env ruby

# For tomorrow:
# I think the solution is to note when I visit a position and what my direction
# is when I visit that position. As long as I don't visit the same position in
# the same direction, I'm not in a loop. But if I revisit a position and I'm
# in the same direction as the last visit, I've hit a loop.
#
# For testing all the possibily places I can put a block, I can just go through
# the 130*130 scenarios. I can speed it up a bit by skipping scenarios where
# there's already a # at the position where I'm considering placing my block.
# I know those placements lead to a grid escape.

data_grid = []
data_start = [0, 0]
sum = 0

class Guard
  attr_accessor :dir, :x, :y, :visited

  def initialize(newx, newy, dir)
    self.x       = newx
    self.y       = newy
    self.dir     = dir
    self.visited = {}
  end

  def turn
    case dir
    when '^'
      self.dir = '>'
    when '>'
      self.dir = 'v'
    when 'v'
      self.dir = '<'
    when '<'
      self.dir = '^'
    end
  end

  def mark_visited
    key = "#{x},#{y}"
    if visited[key]
      visited[key].push(dir)
    else
      visited[key] = [dir]
    end
  end

  def next_step
    next_x   = x
    next_y   = y
    case dir
    when '^'
      next_x -= 1
    when '>'
      next_y += 1
    when 'v'
      next_x += 1
    when '<'
      next_y -= 1
    end
    [next_x, next_y]
  end

  def loop?(newx, newy)
    key = "#{newx},#{newy}"
    return true if visited[key]&.include?(dir)

    false
  end
end

def on_grid?(newx, newy, grid)
  return true if newx >= 0 && newx < grid.length && newy >= 0 && newy < grid[newx].length

  false
end

File.readlines('input-006.txt', chomp: true).each do |line|
  data_grid.append(line.split(''))
  data_start = [data_grid.length - 1, data_grid[-1].find_index('^')] if data_grid[-1].find_index('^')
end

i = 0
while i < data_grid.length
  j = 0
  while j < data_grid[i].length
    puts "Iteration: #{i} #{j}"
    grid = data_grid.map(&:clone)

    grid[i][j] = '#'
    guard      = Guard.new(data_start[0], data_start[1], '^')

    loop do
      next_step = guard.next_step

      break unless on_grid?(next_step[0], next_step[1], grid)

      guard.mark_visited

      if grid[next_step[0]][next_step[1]] == '#'
        guard.turn
        next
      end

      if guard.loop?(next_step[0], next_step[1])
        sum += 1
        break
      end

      guard.x = next_step[0]
      guard.y = next_step[1]
    end
    j += 1
  end
  i += 1
end

pp sum
