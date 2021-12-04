require 'time'

INPUT_FILE = 'input/input.txt'

start_time = Time.now

# forward 5 adds 5 to horizontal_pos
horizontal_pos = 0

# up 5 subtracts 5
# down 5 adds 5 to depth
depth = 0

File.foreach(INPUT_FILE) do |line|
  movement, value = line.split(' ')

  case movement
  when 'forward'
    horizontal_pos += value.to_i
  when 'up'
    depth -= value.to_i
  when 'down'
    depth += value.to_i
  else
    'suck it'
  end
end

end_time = Time.now

puts "Finished in #{end_time - start_time} seconds."
puts "Final answer: #{horizontal_pos * depth}"
