#!/usr/bin/env ruby

require 'io/console'

inputs = []
sum = 0

def continue_execution
  print 'press any key'
  $stdin.getch
  puts ''
end

def add(target, acc, array)
  return false if array.empty?

  acc += array.shift
  return true if (target == acc) && array.empty?

  add(target, acc, array.clone) || multiply(target, acc, array.clone) || concatenate(target, acc, array.clone)
end

def multiply(target, acc, array)
  return false if array.empty?

  acc *= array.shift
  return true if (target == acc) && array.empty?

  add(target, acc, array.clone) || multiply(target, acc, array.clone) || concatenate(target, acc, array.clone)
end

def concatenate(target, acc, array)
  return false if array.empty?

  acc = "#{acc}#{array.shift}".to_i
  return true if (target == acc) && array.empty?

  add(target, acc, array.clone) || multiply(target, acc, array.clone) || concatenate(target, acc, array.clone)
end

File.readlines('input-007.txt', chomp: true).each do |line|
  solution, ins = line.split(':')
  inputs.push(ins.split.map(&:to_i).prepend(solution.to_i))
end

# pp inputs

inputs.each do |input|
  solution = input.shift
  start = input.shift
  puts "#{solution}: #{start} #{input}"
  sum += solution if add(solution, start, input.clone) || multiply(solution, start, input.clone) || concatenate(solution, start, input.clone)
end

puts ''
pp sum
