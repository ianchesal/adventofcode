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

row = 1
while row < grid.length - 1
  col = 1
  while col < grid[row].length - 1
    if grid[row][col] == 'A'
      puts "Found A at [#{row}][#{col}]"
      xes = 0
      # Check NW<>SE direction
      word_one = grid[row-1][col-1] + grid[row][col] + grid[row+1][col+1]
      puts "  #{word_one}"
      # Check NE<>SW direction
      word_two = grid[row-1][col+1] + grid[row][col] + grid[row+1][col-1]
      puts "  #{word_two}"
      sum += 1 if (word_one == 'MAS' || word_one.reverse == 'MAS') && (word_two == 'MAS' ||  word_two.reverse == 'MAS')
    end
    col +=1
  end
  row += 1
end

pp sum
