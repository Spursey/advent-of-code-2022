# frozen_string_literal: true

# Three Measurement Sliding Window: Count the number of times
# the sum of measurements in the three measurement sliding window increases

# Input: List of provided measurements

# Output: Number of times the current three-measurement group
# increased compared to the previous

require 'time'

INPUT_FILE_PATH = 'input/input.txt'

start_time = Time.now

inputs = []

File.readlines(INPUT_FILE_PATH).each do |line|
  inputs << line.to_i
end

prev_sum = 0
cur_sum = 0
counter = 0
cur_measurements = []
meas_increases = 0

inputs.each_with_index do |meas, index|

  next unless inputs[counter + 3]
  prev_sum = inputs[counter] + inputs[counter + 1] + inputs[counter + 2]
  cur_sum  = inputs[counter + 1] + inputs[counter + 2] + inputs[counter + 3]

  if prev_sum < cur_sum
    meas_increases += 1
  end

  prev_sum = 0
  cur_sum  = 0

  counter += 1
end

end_time = Time.now

print "Finished in #{end_time - start_time} seconds.\n"

print meas_increases
