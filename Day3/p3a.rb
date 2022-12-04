#frozen_string_literal: true

INPUT_FILE = 'input.txt'

shared_characters = [] 
rucksack_count = 0

File.foreach(INPUT_FILE) do |line|
  shared_characters[rucksack_count] = []

  first_compartment = line[0..(line.length / 2) - 1]
  second_compartment = line[(line.length / 2)..line.length]

  first_compartment.each_char.each do |char|
    second_compartment.each_char.each do |char2|
      if char == char2 && !shared_characters[rucksack_count].include?(char2)
        shared_characters[rucksack_count] = char2
      end
    end
  end

  rucksack_count += 1
end

total_priority = 0

(0..rucksack_count).each do |counter|
  next if shared_characters[counter].nil?

  if shared_characters[counter] == shared_characters[counter].downcase
    total_priority += (shared_characters[counter].ord - 96)
  else
    total_priority += (shared_characters[counter].ord - 38)
  end
end

puts total_priority
