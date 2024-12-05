#!/usr/bin/env ruby

rules = []
manuals = []
invalids = []
sum = 0

File.readlines('input-005-rules.txt', chomp: true).each do |line|
  rules.append(line.split('|').map(&:to_i))
end

File.readlines('input-005-manuals.txt', chomp: true).each do |line|
  manuals.append(line.split(',').map(&:to_i))
end

manuals.each_with_index do |manual, mindx|
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
  if !valid
    invalids.append(manual)
  end
end

invalids.each do |manual|
  rind = 0
  while(rind < rules.length)
    rule = rules[rind]
    rind += 1
    a = manual.find_index(rule[0])
    b = manual.find_index(rule[1])
    next if !a || !b
    if a >= b
      manual[a], manual[b] = manual[b], manual[a]
      rind = 0 # Start rule checks all over again
    end
  end
end

invalids.each do |manual|
  sum += manual[(manual.length/2).floor]
end

pp sum
