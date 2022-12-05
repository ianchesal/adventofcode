#!/usr/bin/env ruby

require 'pp'
require 'io/console'

def pause_program
  print "press any key"
  STDIN.getch
  print "            \r"
end

STACKS = [
%w(N S D C V Q T),
%w(M F V),
%w(F Q W D P N H M),
%w(D Q R T F),
%w(R F M N Q H V B),
%w(C F G N P W Q),
%w(W F R L C T),
%w(T Z N S),
%w(M S D J R Q H N),
]

pp STACKS
puts

File.readlines('input.txt').each do |line|
  line.chomp!
  next if line.split(' ')[0] != 'move'
  moves = line.split(' ')[1].to_i
  from_stack = line.split(' ')[3].to_i
  to_stack = line.split(' ')[5].to_i

  puts "move #{moves} from #{from_stack} to #{to_stack}"
  puts

  m = 0
  while m < moves
    STACKS[to_stack-1].push(
      STACKS[from_stack-1].pop
    )
    m += 1
  end

  pp STACKS
  puts
  #pause_program
end

puts
pp STACKS
puts

output = ''
i = 0
while i < STACKS.length
  output += STACKS[i][-1]
  i += 1
end
puts
puts output
