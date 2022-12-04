#!/usr/bin/env ruby

def shape(s)
  return 0 if s == 'A' or s == 'X' # rock
  return 1 if s == 'B' or s == 'Y' # paper
  2 # scissors
end

OUTCOMES = [
[3,6,0],
[0,3,6],
[6,0,3]
]

def score(line)
  opponent = shape(line[0])
  you = shape(line[2])
  OUTCOMES[opponent][you] + you + 1
end

total = 0

File.readlines('input.txt').each do |line|
  line.chomp!
  total += score(line)
end

puts
puts "Total score is #{total}"
