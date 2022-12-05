#frozen_string_literal: true

INPUT_FILE = 'input.txt'

total_range_overlaps = 0

File.foreach(INPUT_FILE) do |line|

  first_range, second_range = line.split(',')

  first_range = first_range.split('-').map { |x| x.to_i }
  second_range = second_range.split('-').map { |x| x.to_i }

  first_range_in_second = false
  second_range_in_first = false

  if first_range[0] == first_range[1]
    first_range_in_second = true if (second_range[0]..second_range[1]).include?(first_range[0])
  else
    (first_range[0]..first_range[1]).each do |number|
      first_range_in_second = true if (second_range[0]..second_range[1]).include?(number)
    end
  end 

  if second_range[0] == second_range[1]
    second_range_in_first = true if (first_range[0]..first_range[1]).include?(second_range[0])
  else
    (second_range[0]..second_range[1]).each do |number|
      second_range_in_first = true if (first_range[0]..first_range[1]).include?(number)
    end
  end

  total_range_overlaps += 1 if first_range_in_second || second_range_in_first
end

puts total_range_overlaps

