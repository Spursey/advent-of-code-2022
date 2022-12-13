#frozen_string_literal: true

INPUT_FILE = 'input.txt'

x_register = 1
total_cycle_count = 0

cycles_by_action = { 
  "noop" => 1,
  "addx" => 2
}

cycles_we_care_about = [20, 60, 100, 140, 180, 220]

signal_stengths = []

File.foreach(INPUT_FILE) do |line|
  action, value = line.split(' ')

  i = 1
  until i > cycles_by_action[action]
    total_cycle_count += 1

    i += 1

    if cycles_we_care_about.include?(total_cycle_count)
      signal_stengths << total_cycle_count * x_register
    end
  end

  if action == 'addx'
    x_register += value.to_i
  end
end

puts signal_stengths.sum
