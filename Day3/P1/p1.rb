# frozen_string_literal: true

# Binary Diagnostic: Use binary numbers to determine
# submarine power consumption

# Input: List of binary numbers output by submarine diagnostic tool

# Output: Product of Epsilon Rate and Gamma Rate determined
# via input from the diagnostic tool

require 'time'

INPUT_FILE = 'input/input.txt'

start_time = Time.now

# 1024 512 256 128 64 32 16 8 4 2 0

binary_numbers = []

counter = 0

ones_count = []
zeros_count = []

gamma_value = []
epsilon_value = []

File.foreach(INPUT_FILE) do |line|
  binary_numbers << line.chomp.split('').map(&:to_i)
  counter += 1
end

counter = 0

binary_numbers.each_with_index do |number, index|
  if index.zero?
    while counter < number.length
      ones_count << 0
      zeros_count << 0

      counter += 1
    end
  end

  number.each_with_index do |digit, num_index|
    if digit == 1
      ones_count[num_index] += 1
    else
      zeros_count[num_index] += 1
    end
  end
end

ones_count.each_with_index do |_number, index|
  if ones_count[index] > zeros_count[index]
    gamma_value[index] = 1
    epsilon_value[index] = 0
  else
    epsilon_value[index] = 1
    gamma_value[index] = 0
  end
end

gamma_in_decimal = gamma_value.join.to_s.to_i(2)
epsilon_in_decimal = epsilon_value.join.to_s.to_i(2)

end_time = Time.now

puts "Finished in #{end_time - start_time} seconds."
puts "Final answer: #{gamma_in_decimal * epsilon_in_decimal}"
