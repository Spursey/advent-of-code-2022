#frozen_string_literal: true

INPUT_FILE = 'input.txt'

total_score = 0

scores = {
  A: {
    X: 3,
    Y: 4,
    Z: 8
  },
  B: {
    X: 1,
    Y: 5,
    Z: 9
  },
  C: {
    X: 2,
    Y: 6,
    Z: 7
  }
}

total_score = 0

File.foreach(INPUT_FILE) do |line|
  opponent_choice  = line.split(' ')[0].chomp
  my_choice = line.split(' ')[1]

  total_score += scores[opponent_choice.to_sym][my_choice.to_sym]
end

puts total_score
