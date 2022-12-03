#frozen_string_literal: true

INPUT_FILE = 'input.txt'

shared_characters = [] 
rucksack_group = 0

line_counter = 0
current_rucksacks = []

File.foreach(INPUT_FILE) do |line|
  shared_characters[rucksack_group] = []

  current_rucksacks[line_counter] = line
  line_counter += 1

  if line_counter % 3 == 0 && line_counter != 0
    current_rucksacks[0].each_char.each do |char|
      current_rucksacks[1].each_char.each do |char2|
        current_rucksacks[2].each_char.each do |char3|
          if char == char2 && char2 == char3 && !shared_characters[rucksack_group].include?(char3)
            shared_characters[rucksack_group] << char3
          end
        end
      end
    end

    rucksack_group += 1
    line_counter = 0
  end
end

total_priority = 0

(0..rucksack_group).each do |group|
  next if shared_characters[group].nil?

  if shared_characters[group].first == shared_characters[group].first.downcase
    total_priority += (shared_characters[group].first.ord - 96)
  else
    total_priority += (shared_characters[group].first.ord - 38)
  end
end

puts total_priority
