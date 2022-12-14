#!/usr/bin/env ruby

require 'pp'
require 'io/console'

def pause_program
  # print 'press any key'
  $stdin.getch
  puts
  # print "            \r"
end

def correct?(l, r)
  return nil if l.empty? && r.empty?
  return true if l.empty?
  return false if r.empty?

  heads = [l.first, r.first]

  if heads[0].instance_of?(Integer) && heads[1].instance_of?(Integer)
    return true if heads[0] < heads[1]
    return false if heads[0] > heads[1]
  else
    [0,1].each do |i|
      heads[i] = [heads[i]] if heads[i].instance_of?(Integer)
    end
    correct = correct?(heads[0], heads[1])
    return correct if (correct || correct == false)
  end
  correct?(l.slice(1..), r.slice(1..))
end

left = []
right = []
correct = []

pair = 0
File.readlines('input.txt').each_with_index do |line, idx|
  next if (idx + 1) % 3 == 0
  line.chomp!
  if (idx + 1) % 3 == 2
    pair += 1
    right = eval(line)
    if correct?(left, right)
      correct.append(pair)
    end
  else
    left = eval(line)
  end
end

puts "Sum: #{correct.sum}"
