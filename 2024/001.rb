#!/usr/bin/env ruby

left  = []
right = []
sum   = 0

File.readlines('input-001.txt', chomp: true).each do |line|
  (one, two) = line.split()
  left.push(Integer(one))
  right.push(Integer(two))
end

left.sort!
right.sort!

while(!left.empty?)
  sum += (left.shift - right.shift).abs
end

pp sum
