#!/usr/bin/env ruby

def sorted?(ary)
  return true if ary == ary.sort
  return true if ary ==  ary.sort.reverse
  false
end

def safe?(ary)
  return false unless sorted?(ary)
  i = 0
  j = 1
  while( j < ary.length)
    diff = (ary[i] - ary[j]).abs
    return false if diff > 3 || diff < 1
    i += 1
    j += 1
  end
  true
end


sum   = 0

File.readlines('input-002.txt', chomp: true).each do |line|
  report = line.split().map(&:to_i)
  if safe?(report)
    sum += 1
    next
  end

  i = 0

  while(i < report.length)
    damped_report = report.dup
    damped_report.delete_at(i)
    # pp damped_report
    if safe?(damped_report)
      sum += 1
      break
    end
    i += 1
  end
end

pp sum
