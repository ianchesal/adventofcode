#!/usr/bin/env ruby

require 'io/console'

dmap = []
files = {}
free_space = {}

def continue_execution
  print 'press any key'
  $stdin.getch
  puts ''
end

id = 0

File.readlines(ARGV[0], chomp: true).each do |line|
  is_file = true
  line.split('').each do |char|
    char = char.to_i
    insert_char = '.'
    if is_file
      files[id] = {
        index: dmap.length,
        size: char
      }
      insert_char = id
      id += 1
      is_file = false
    else
      free_space[dmap.length] = {
        index: dmap.length,
        size: char
      }
      is_file = true
    end
    i = 0
    while i < char
      dmap << insert_char
      i += 1
    end
  end
end

files.keys.reverse.each do |fnum|
  free_space.keys.sort.each do |freeblock|
    next unless free_space[freeblock][:size] >= files[fnum][:size]

    # Don't move file blocks to the right
    next if free_space[freeblock][:index] >= files[fnum][:index]

    # Make the current file space free space
    free_space[files[fnum][:index]] = {
      index: files[fnum][:index],
      size: files[fnum][:size]
    }
    # Move the file in to the free space
    files[fnum][:index] = free_space[freeblock][:index]
    # Reduce the free space block size
    free_space[freeblock][:size] -= files[fnum][:size]
    # Delete the free space block if it's empty now
    if free_space[freeblock][:size].zero?
      free_space.delete(freeblock)
    else
      # Otherwise adjsut the index
      free_space[freeblock][:index] += files[fnum][:size]
    end
  end
end

# Rebuild dmap. Start out assuming all empty space.
dmap = ['.'] * dmap.length
# Then fill in the files
files.each do |key, file|
  i = file[:index]
  while i < file[:index] + file[:size]
    dmap[i] = key
    i += 1
  end
end

sum = 0

dmap.each_with_index do |elem, ind|
  next if elem == '.'

  sum += elem * ind
end

pp sum
