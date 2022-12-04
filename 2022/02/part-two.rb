#!/usr/bin/env ruby

def shape(s)
  return 0 if s == 'A' # rock
  return 1 if s == 'B' # paper
  2 # scissors
end

def outcome(o)
  return 0 if o == 'X' # lose
  return 1 if o == 'Y' # draw
  2 # win
end

OUTCOMES = [
[2,0,1],
[0,1,2],
[1,2,0]
]

def score(line)
  opponent = shape(line[0])
  you = OUTCOMES[opponent][outcome(line[2])]
  return (outcome(line[2]) * 3) + you + 1
end

total = 0

File.readlines('input.txt').each do |line|
  line.chomp!
  total += score(line)
end

puts
puts "Total score is #{total}"
