#!/usr/bin/env ruby

require 'pp'
require 'io/console'

def pause_program
  # print 'press any key'
  $stdin.getch
  puts
  # print "            \r"
end

class Monkey

  attr_accessor :name, :items, :operation, :test, :if_true, :if_false, :activity, :lcm

  def initialize(name:, items:, operation:, test:, if_true:, if_false:, lcm: 1)
    self.name = name
    self.items = items
    self.operation = operation
    self.test = test
    self.if_true = if_true
    self.if_false = if_false
    self.lcm = lcm
    self.activity = 0
  end

  def play
    puts "   Monkey #{self.name} is playing"
    while self.items.length > 0
      inspect(self.items.shift)
    end
  end

  def inspect(value)
    value = self.operation.call(value) % self.lcm
    if value % self.test == 0
      MONKEYS[self.if_true].catch(value)
    else
      MONKEYS[self.if_false].catch(value)
    end
    self.activity += 1
  end

  def catch(value)
    self.items.append(value)
  end
end

MONKEYS = []

MONKEYS[0] = Monkey.new(
  name: 0,
  items: [89, 74],
  operation: lambda { |i| i * 5 },
  test: 17,
  if_true: 4,
  if_false: 7,
)

MONKEYS[1] = Monkey.new(
  name: 1,
  items: [75, 69, 87, 57, 84, 90, 66, 50],
  operation: lambda { |i| i + 3 },
  test: 7,
  if_true: 3,
  if_false: 2,
)

MONKEYS[2] = Monkey.new(
  name: 2,
  items: [55],
  operation: lambda { |i| i + 7 },
  test: 13,
  if_true: 0,
  if_false: 7,
)

MONKEYS[3] = Monkey.new(
  name: 3,
  items: [69, 82, 69, 56, 68],
  operation: lambda { |i| i + 5 },
  test: 2,
  if_true: 0,
  if_false: 2,
)

MONKEYS[4] = Monkey.new(
  name: 4,
  items: [72, 97, 50],
  operation: lambda { |i| i + 2 },
  test: 19,
  if_true: 6,
  if_false: 5,
)

MONKEYS[5] = Monkey.new(
  name: 5,
  items: [90, 84, 56, 92, 91, 91],
  operation: lambda { |i| i * 19 },
  test: 3,
  if_true: 6,
  if_false: 1,
)

MONKEYS[6] = Monkey.new(
  name: 6,
  items: [63, 93, 55, 53],
  operation: lambda { |i| i * i },
  test: 5,
  if_true: 3,
  if_false: 1,
)

MONKEYS[7] = Monkey.new(
  name: 7,
  items: [50, 61, 52, 58, 86, 68, 97],
  operation: lambda { |i| i + 4 },
  test: 11,
  if_true: 5,
  if_false: 4,
)

# No lie, this trick for reducing item sizes was totally non-obvious to me.
# Got it after looking at some solutions in the subreddit.
lcm = [17, 7, 13, 2, 19, 3, 5, 11].reduce(:lcm)
MONKEYS.each { |m| m.lcm = lcm }

round = 0
while round < 10000
  puts "Round #{round}"
  (0..7).each do |m|
    MONKEYS[m].play
  end
  round += 1
end

(0..7).each do |m|
  puts "Monkey #{m} inspected #{MONKEYS[m].activity} times"
end

puts MONKEYS.map(&:activity).max(2).reduce(:*)
