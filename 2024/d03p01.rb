#!/usr/bin/env ruby

sum   = 0

File.readlines('input-003.txt', chomp: true).each do |line|
  line.scan(/mul\((\d{1,3}),(\d{1,3})\)/).each do |pair|
    sum += pair[0].to_i * pair[1].to_i
  end
end

pp sum
