#!/usr/bin/env ruby

def value(char)
  if char.ord < 97
    return char.ord - 38
  end
  char.ord - 96
end

total = 0
bags = []
elf = 0

File.readlines('input.txt').each do |line|
  line.chomp!
  bags[elf] = line.split('')
  elf += 1
  if elf == 3
    elf = 0
    total += value(bags[0].intersection(bags[1], bags[2]).join(''))
  end
end

puts
puts "Total score is #{total}"
