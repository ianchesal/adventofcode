#!/usr/bin/env ruby

require 'io/console'

dmap = []

def continue_execution
  print 'press any key'
  $stdin.getch
  puts ''
end

id = 0

File.readlines('input-009.txt', chomp: true).each do |line|
  is_file = true
  line.split('').each do |char|
    char = char.to_i
    insert_char = '.'
    if is_file
      insert_char = id
      id += 1
      is_file = false
    else
      is_file = true
    end
    i = 0
    while i < char
      dmap << insert_char
      i += 1
    end
  end
end

i = 0
j = dmap.length - 1

loop do
  i += 1 while i < dmap.length && dmap[i] != '.'
  j -= 1 while j >= 0 && dmap[j] == '.'

  break if i >= dmap.length || j.negative?
  break if i > j

  dmap[i] = dmap[j]
  dmap[j] = '.'
end

sum = 0

dmap.each_with_index do |elem, ind|
  next if elem == '.'

  sum += elem * ind
end

pp sum
