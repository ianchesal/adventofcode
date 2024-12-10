#!/usr/bin/env ruby

require 'io/console'

inputs = []
sum = 0

def continue_execution
  print 'press any key'
  $stdin.getch
  puts ''
end

def generate_operations(values)
  # puts 'generate_operations()'
  operations = []
  i = 0
  while i < values.length - 1
    ops = Array.new(values.length - 1, '+')
    j = 0
    while j < i
      ops[j] = '*'
      j += 1
    end
    k = values.length - 1
    while k >= j
      ops[k] = '*' if k <= ops.length - 1
      ops[k + 1] = '+' if k <= ops.length - 2
      operations.append(ops.clone) if ops != operations[-1]
      # pp operations
      k -= 1
    end
    i += 1
  end

  operations
end

def compute(values, operations)
  # puts 'compute()'
  # pp values
  # pp operations
  total    = values.shift
  operator = operations.shift

  while values.length.positive?
    case operator
    when '+'
      total += values.shift
    when '*'
      total *= values.shift
    else
      raise StandardError("Unknown operation: #{operator}")
    end
    operator = operations.shift
  end

  # pp total

  total
end

File.readlines('input-007.txt', chomp: true).each do |line|
  solution, ins = line.split(':')
  inputs.push(ins.split.map(&:to_i).prepend(solution.to_i))
end

# pp inputs

inputs.each do |input|
  solution = input.shift
  generate_operations(input).each do |ops|
    computed = compute(input.clone, ops.clone)
    next unless solution == computed

    puts 'Found solution at: '
    pp input
    pp ops
    pp solution
    sum += solution
    # continue_execution
    break
  end
  puts "Sum: #{sum}"
end

puts ''
pp sum
