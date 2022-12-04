#!/usr/bin/env ruby

elves = []

elf = 1
calories = 0
File.readlines('input.txt').each do |line|
  line.chomp!
  if line.empty?
    elves << {elf: elf, calories: calories}
    calories = 0
    elf += 1
  else
    calories += line.to_i
  end
end

elves.sort_by! { |hsh| hsh[:calories] }
total = elves[-1][:calories] + elves[-2][:calories] + elves[-3][:calories]

puts
puts "Total calories carried by top three elves is #{total} calories"
