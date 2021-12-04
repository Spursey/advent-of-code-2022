# frozen_string_literal: true

# Sonar Sweep: Determine the number of times
# the depth increases from one depth to the NEXT

# Input: List of provided depths

# Output: Quantity of depth measurement increases
# when current depth is compared to the previous depth

require 'time'

INPUT_FILE_PATH = 'input/input.txt'

start_time = Time.now

depths = []

File.open(INPUT_FILE_PATH, 'r') do |f|
  f.each_line do |line|
    depths << line.to_i
  end
end

previous_depth = nil
current_depth = 0

depth_increases = 0

depths.each do |depth|
  unless previous_depth
    previous_depth = depth
    next
  end

  current_depth = depth
  if current_depth > previous_depth
    depth_increases += 1
  end

  previous_depth = current_depth
  current_depth = 0
end

end_time = Time.now

print "Finished in #{end_time - start_time} seconds.\n"

print depth_increases
