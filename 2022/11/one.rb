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

  attr_accessor :name, :items, :operation, :test, :if_true, :if_false, :activity

  def initialize(name:, items:, operation:, test:, if_true:, if_false:)
    self.name = name
    self.items = items
    self.operation = operation
    self.test = test
    self.if_true = if_true
    self.if_false = if_false
    self.activity = 0
  end

  def play
    puts "   Monkey #{self.name} is playing"
    while self.items.length > 0
      inspect(self.items.shift)
    end
  end

  def inspect(value)
    value = self.operation.call(value)
    value = (value / 3).floor
    if self.test.call(value)
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
  test: lambda { |i| i % 17 == 0 },
  if_true: 4,
  if_false: 7,
)

MONKEYS[1] = Monkey.new(
  name: 1,
  items: [75, 69, 87, 57, 84, 90, 66, 50],
  operation: lambda { |i| i + 3 },
  test: lambda { |i| i % 7 == 0 },
  if_true: 3,
  if_false: 2,
)

MONKEYS[2] = Monkey.new(
  name: 2,
  items: [55],
  operation: lambda { |i| i + 7 },
  test: lambda { |i| i % 13 == 0 },
  if_true: 0,
  if_false: 7,
)

MONKEYS[3] = Monkey.new(
  name: 3,
  items: [69, 82, 69, 56, 68],
  operation: lambda { |i| i + 5 },
  test: lambda { |i| i % 2 == 0 },
  if_true: 0,
  if_false: 2,
)

MONKEYS[4] = Monkey.new(
  name: 4,
  items: [72, 97, 50],
  operation: lambda { |i| i + 2 },
  test: lambda { |i| i % 19 == 0 },
  if_true: 6,
  if_false: 5,
)

MONKEYS[5] = Monkey.new(
  name: 5,
  items: [90, 84, 56, 92, 91, 91],
  operation: lambda { |i| i * 19 },
  test: lambda { |i| i % 3 == 0 },
  if_true: 6,
  if_false: 1,
)

MONKEYS[6] = Monkey.new(
  name: 6,
  items: [63, 93, 55, 53],
  operation: lambda { |i| i * i },
  test: lambda { |i| i % 5 == 0 },
  if_true: 3,
  if_false: 1,
)

MONKEYS[7] = Monkey.new(
  name: 7,
  items: [50, 61, 52, 58, 86, 68, 97],
  operation: lambda { |i| i + 4 },
  test: lambda { |i| i % 11 == 0 },
  if_true: 5,
  if_false: 4,
)

round = 0
while round < 20
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
