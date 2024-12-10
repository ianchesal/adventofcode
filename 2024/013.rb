#!/usr/bin/env ruby

require 'io/console'

inputs = []
sum = 0

def continue_execution
  print 'press any key'
  $stdin.getch
  puts ''
end

def subtract(target, array)
  puts "subtract(#{target}, #{array})"

  val = array.pop
  return (target - val) == array[0] if array.length == 1
  return false if (target - val) < 0

  subtract(target - val, array.clone) || divide(target - val, array.clone)
end

def divide(target, array)
  puts "divide(#{target}, #{array})"

  val = array.pop
  return (target / val) == array[0] if array.length == 1
  return false if target % val != 0

  subtract(target / val, array.clone) || divide(target / val, array.clone)
end

File.readlines('input-007.txt', chomp: true).each do |line|
  solution, ins = line.split(':')
  inputs.push(ins.split.map(&:to_i).prepend(solution.to_i))
end

# pp inputs

inputs.each do |input|
  solution = input.shift
  puts "#{solution}: #{input}"
  sum += solution if subtract(solution, input.clone) || divide(solution, input.clone)
end

puts ''
pp sum
