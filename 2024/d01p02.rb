#!/usr/bin/env ruby

left  = []
right = []
sum   = 0

File.readlines('input-001.txt', chomp: true).each do |line|
  (one, two) = line.split()
  left.push(Integer(one))
  right.push(Integer(two))
end

histogram = right.tally

while(!left.empty?)
  l = left.shift
  sum += l * histogram.fetch(l, 0)
end

pp sum
