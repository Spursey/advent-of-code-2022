# frozen_string_literal: true

# Dive! Part Duece: Determine Depth, Aim and Horizontal Position of a submarine
# given a list of commands which have changed to include depth in the 'forward'
# command, and only aim in the 'up' and 'down' commands

# Input: List of provided commands

# Output: Product of the Depth and Horizontal Position of the submarine

require 'time'

INPUT_FILE = 'input/input.txt'

start_time = Time.now

# forward 5 adds 5 to horizontal_pos
horizontal_pos = 0

# up 5 subtracts 5
# down 5 adds 5 to depth
depth = 0
aim = 0

File.foreach(INPUT_FILE) do |line|
  movement, value = line.split(' ')
  case movement
  when 'forward'
    horizontal_pos += value.to_i
    depth += (aim * value.to_i)
  when 'up'
    aim -= value.to_i
  when 'down'
    aim += value.to_i
  else
    'suck it'
  end
end

end_time = Time.now

puts "Finished in #{end_time - start_time} seconds."
puts "Final answer: #{horizontal_pos * depth}"
