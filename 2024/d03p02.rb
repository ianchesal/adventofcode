#!/usr/bin/env ruby

sum     = 0
do_mult = true

File.readlines('input-003.txt', chomp: true).each do |line|
  line.scan(/(mul\((\d{1,3}),(\d{1,3})\)|don\'t\(\)|do\(\))/).each do |inst|
    if inst[0].start_with?('mul') && do_mult
      sum += inst[1].to_i * inst[2].to_i
    elsif inst[0] == 'don\'t()'
      do_mult = false
    elsif inst[0] == 'do()'
      do_mult = true
    end
  end
end

pp sum
