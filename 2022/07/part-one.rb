#!/usr/bin/env ruby

require 'pp'
require 'io/console'

def pause_program
  print "press any key"
  STDIN.getch
  print "            \r"
end

DIRS = Hash.new()
DSTACK = ['']

ElfFile = Struct.new(:name, :size, keyword_init: true)

ElfDir = Struct.new(:files, :subdirs, keyword_init: true) do

  def size
    t = 0
    for file in files
      t += file.size
    end
    return t
  end

  def total_size
    t = 0
    for dir in subdirs.uniq
      t += DIRS[dir].total_size
    end
    return t + size
  end
end

File.readlines('input.txt').each do |line|
  line.chomp!

  if line.match(/^\$ cd/)
    dname = line.split(' ', 3)[2]
    if dname == ".."
      # Pop the directory stack
      DSTACK.pop
    else
      # Directory names can repeat so we need to store the normalized path
      dname = DSTACK[-1] + '/' + dname
      # Add new directory struct and push on to the stack
      DIRS[dname] = ElfDir.new(files: [], subdirs: []) if ! DIRS.has_key?(dname)
      DSTACK.push(dname)
    end
  elsif line.match(/^\$ ls/)
    # No-op
  elsif line.match(/^dir /)
    # It's a subdir to remember
    DIRS[DSTACK[-1]].subdirs.push(DSTACK[-1] + '/' + line.split(' ', 2)[1])
  else
    # It's a file with it's size
    DIRS[DSTACK[-1]].files.push(
      ElfFile.new(
        name: line.split(' ', 2)[1],
        size: line.split(' ', 2)[0].to_i
      )
    )
  end
end

total = 0
for dir in DIRS.keys
  next if dir == '/'
  next if DIRS[dir].size > 100000
  total += DIRS[dir].total_size if DIRS[dir].total_size <= 100000
end

puts total
