#!/usr/bin/env ruby

require 'io/console'

nodes     = {}
antinodes = {}
grid = []

def continue_execution
  print 'press any key'
  $stdin.getch
  puts ''
end

def rise_run(coord_a, coord_b)
  [coord_b[0] - coord_a[0],
   coord_b[1] - coord_a[1]]
end

File.readlines('input-008.txt', chomp: true).each do |line|
  grid.append(line.split(''))
  grid[-1].each_with_index do |node, idx|
    next if node == '.'

    nodes[node] = [] unless nodes.key?(node)
    nodes[node].append([grid.length - 1, idx])
  end
end

pp grid.length
pp grid[0].length

nodes.each do |freq, coords|
  puts "Nodes: #{freq} -> #{coords}"
  antinodes[freq] = []
  coords.combination(2).each do |pair|
    node_a, node_b = pair
    (diff_ax, diff_ay) = rise_run(node_a, node_b)
    (diff_bx, diff_by) = rise_run(node_b, node_a)
    antinodes[freq] << [[node_a[0] + (1 * diff_bx), node_a[1] + (1 * diff_by)], [node_b[0] + (1 * diff_ax), node_b[1] + (1 * diff_ay)]]
  end
end

pp antinodes.values.flatten(2).uniq

pp(antinodes.values.flatten(2).uniq.select { |coord| coord[0] >= 0 && coord[0] < grid.length && coord[1] >= 0 && coord[1] < grid[0].length }.count)
