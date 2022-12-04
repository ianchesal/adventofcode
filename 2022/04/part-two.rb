#!/usr/bin/env ruby

def overlaps?(a, b)
  diff = a.intersection(b)
  !diff.empty?
end

total = 0

File.readlines('input.txt').each do |line|
  line.chomp!
  elfa = line.split(',')[0].split('-')
  elfb = line.split(',')[1].split('-')
  elfa =* (elfa[0]..elfa[1])
  elfb =* (elfb[0]..elfb[1])
  total += 1 if overlaps?(elfa, elfb)
end

puts
puts "Total score is #{total}"
