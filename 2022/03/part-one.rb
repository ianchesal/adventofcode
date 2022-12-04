#!/usr/bin/env ruby

def value(char)
  if char.ord < 97
    return char.ord - 38
  end
  char.ord - 96
end

total = 0

File.readlines('input.txt').each do |line|
  line.chomp!
  compa = line.slice(0, line.length/2).split('')
  compb = line.slice(line.length/2, line.length/2).split('')
  total += value((compa & compb).join(''))
end

puts
puts "Total score is #{total}"
