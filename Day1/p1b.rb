#frozen_string_literal: true

INPUT_FILE = 'input.txt'

calories_file = File.open(INPUT_FILE)
calorie_data = calories_file.readlines.map(&:chomp)

current_total_calories = 0
total_calories_per_elf = []

calorie_data.each do |calorie|
  unless calorie.empty?
    current_total_calories += calorie.to_i
  else
    total_calories_per_elf.push(current_total_calories)

    current_total_calories = 0
  end 
end

total_calories_per_elf.push(current_total_calories)

puts total_calories_per_elf.sort.reverse[0..2].sum