#frozen_string_literal: true

INPUT_FILE = 'input.txt'

x_register = 1

cycles_by_action = { 
  "noop" => 1,
  "addx" => 2
}

cycles_we_care_about = [40, 80, 120, 160, 200, 240]

horizontal_position = 0

File.foreach(INPUT_FILE) do |line|
  action, value = line.split(' ')

  i = 1
  until i > cycles_by_action[action]

    if horizontal_position == (x_register - 1) ||
       horizontal_position == x_register       ||
       horizontal_position == (x_register + 1)
      print "#"
    else
      print '.'
    end

    horizontal_position += 1

    if cycles_we_care_about.include?(horizontal_position)
      print "\n"

      horizontal_position = 0
    end

    i += 1
  end

  if action == 'addx'
    x_register += value.to_i
  end
end
