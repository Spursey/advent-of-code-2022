#frozen_string_literal: true

INPUT_FILE = 'input.txt'

calories_file = File.open(INPUT_FILE)
calorie_data = calories_file.readlines.map(&:chomp)

current_total_calories = 0
largest_total_calories = 0

calorie_data.each do |calorie|
  unless calorie.empty?
    current_total_calories += calorie.to_i
  else
    largest_total_calories = current_total_calories if current_total_calories > largest_total_calories
    
    current_total_calories = 0
  end 
end

puts largest_total_calories