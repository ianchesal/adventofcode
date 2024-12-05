#!/usr/bin/env ruby

rules = []
manuals = []
sum = 0

File.readlines('input-005-rules.txt', chomp: true).each do |line|
  rules.append(line.split('|').map(&:to_i))
end

File.readlines('input-005-manuals.txt', chomp: true).each do |line|
  manuals.append(line.split(',').map(&:to_i))
end

manuals.each do |manual|
  valid = true
  rules.each do |rule|
    a = manual.find_index(rule[0])
    b = manual.find_index(rule[1])
    next if !a || !b
    if a >= b
      valid = false
      break
    end
  end
  if valid
    sum += manual[(manual.length/2).floor]
  end
end

pp sum
