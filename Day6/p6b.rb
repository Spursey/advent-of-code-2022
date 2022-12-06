#frozen_string_literal: true

INPUT_FILE = 'input.txt'

file = File.open(INPUT_FILE)
datastream = file.readlines.map(&:chomp).first

char_counter = 0
current_four_chars = []

datastream.each_char do |char|

  current_four_chars << char
  char_counter += 1

  next unless current_four_chars.length == 14

  if current_four_chars.uniq.length == 14
    break
  end

  current_four_chars.delete_at(0)
end

puts char_counter