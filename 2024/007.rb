#!/usr/bin/env ruby

sum  = 0
grid = []
row  = 0
col  = 0

File.readlines('input-004.txt', chomp: true).each do |line|
  grid[row] = line.chars
  row += 1
end

pp grid

row = 0
while row < grid.length
  col = 0
  while col < grid[row].length
    if grid[row][col] == 'X'
      puts "Found X at [#{row}][#{col}]"
      # Check W
      if col - 3 >= 0
        word = grid[row][col] + grid[row][col-1] + grid[row][col-2] + grid[row][col-3]
        puts "   W: #{word}"
        sum += 1 if word == 'XMAS'
      end
      # Check NW
      if col - 3 >= 0 && row - 3 >= 0
        word = grid[row][col] + grid[row-1][col-1] + grid[row-2][col-2] + grid[row-3][col-3]
        puts "  NW: #{word}"
        sum += 1 if word == 'XMAS'
      end
      # Check N
      if row - 3 >= 0
        word = grid[row][col] + grid[row-1][col] + grid[row-2][col] + grid[row-3][col]
        puts "   N: #{word}"
        sum += 1 if word == 'XMAS'
      end
      # Check NE
      if col + 3 < grid[row].length && row - 3 >= 0
        word = grid[row][col] + grid[row-1][col+1] + grid[row-2][col+2] + grid[row-3][col+3]
        puts "  NE: #{word}"
        sum += 1 if word == 'XMAS'
      end
      # Check E
      if col + 3 < grid[row].length
        word = grid[row][col] + grid[row][col+1] + grid[row][col+2] + grid[row][col+3]
        puts "   E: #{word}"
        sum += 1 if word == 'XMAS'
      end
      # Check SE
      if col + 3 < grid[row].length && row + 3 < grid.length
        word = grid[row][col] + grid[row+1][col+1] + grid[row+2][col+2] + grid[row+3][col+3]
        puts "  SE: #{word}"
        sum += 1 if word == 'XMAS'
      end
      # Check S
      if row + 3 < grid.length
        word = grid[row][col] + grid[row+1][col] + grid[row+2][col] + grid[row+3][col]
        puts "   S: #{word}"
        sum += 1 if word == 'XMAS'
      end
      # Check SW
      if col - 3 >= 0 && row + 3 < grid.length
        word = grid[row][col] + grid[row+1][col-1] + grid[row+2][col-2] + grid[row+3][col-3]
        puts "  SE: #{word}"
        sum += 1 if word == 'XMAS'
      end
    end
    col +=1
  end
  row += 1
end

pp sum
