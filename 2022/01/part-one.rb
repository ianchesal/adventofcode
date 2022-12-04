#!/usr/bin/env ruby

high_elf = 1
high_calories = 0

elf = 1
calories = 0
File.readlines('input.txt').each do |line|
  line.chomp!
  if line.empty?
    if calories > high_calories
      high_calories = calories
      high_elf = elf
    end
    calories = 0
    elf += 1
  else
    calories += line.to_i
  end
end

puts
puts "High elf #{high_elf} has #{high_calories} calories"
