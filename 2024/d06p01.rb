#!/usr/bin/env ruby

grid = []
curr = [0, 0]
guard = '^'
sum = 0

def on_grid?(grid, curr)
  return true if curr[0] >= 0 && curr[0] < grid.length && curr[1] >= 0 && curr[1] < grid[0].length

  false
end

def step(curr, guard, grid)
  grid[curr[0]][curr[1]] = 'X' # Mark current spot visited
  case guard
  when '^'
    return '>' if on_grid?(grid, [curr[0] - 1, curr[1]]) && grid[curr[0] - 1][curr[1]] == ('#')

    curr[0] -= 1
  when '>'
    return 'v' if on_grid?(grid, [curr[0], curr[1] + 1]) && grid[curr[0]][curr[1] + 1] == ('#')

    curr[1] += 1
  when 'v'
    return '<' if on_grid?(grid, [curr[0] + 1, curr[1]]) && grid[curr[0] + 1][curr[1]] == ('#')

    curr[0] += 1
  when '<'
    return '^' if on_grid?(grid, [curr[0], curr[1] - 1]) && grid[curr[0]][curr[1] - 1] == ('#')

    curr[1] -= 1
  end
  guard
end

File.readlines('input-006.txt', chomp: true).each do |line|
  grid.append(line.split(''))
  curr = [grid.length - 1, grid[-1].find_index(guard)] if grid[-1].find_index(guard)
end

guard = step(curr, guard, grid) while on_grid?(grid, curr)

grid.each do |row|
  sum += row.tally['X'] if row.tally['X']
end

pp sum
