#frozen_string_literal: true

INPUT_FILE = 'input.txt'

adjusted_table = []

directions_count = 0
moving_directions = []

reading_directions = false

File.foreach(INPUT_FILE) do |line|
  reading_directions = true if line[0..4].match(/[0-9]/)

  unless reading_directions
    row_tracker = 0

    line.chars.each_slice(4).each do |column|
      adjusted_table[row_tracker] = [] if adjusted_table[row_tracker].nil?

      package = column.join.gsub('[', '')
                           .gsub(']', '')
                           .gsub('    ', '')
                           .gsub(' ', '')
                           .chomp

      adjusted_table[row_tracker].insert(0, package) unless package.empty?

      row_tracker += 1
    end
  else
    next if line[0..4].match(/[0-9]/) || line.chomp.empty?

    moving_directions[directions_count] = {}

    moving_directions[directions_count]['quantity_to_move'] = line.split(' from ')[0].split(' ').last.to_i
    moving_directions[directions_count]['from_position']    = line.split(' from ')[1].split(' ').first.to_i
    moving_directions[directions_count]['to_position']      = line.split(' from ')[1].split(' ').last.to_i
    
    directions_count += 1
  end
end

moving_directions.each do |directions|
  quantity_to_move = directions['quantity_to_move']
  from_where = directions['from_position'] -1
  to_where = directions['to_position'] - 1

  crates_to_move = adjusted_table[from_where].pop(quantity_to_move)

  crates_to_move.reverse.each do |crate|
    adjusted_table[to_where] << crate
  end
end

final_crate_string = ''

adjusted_table.each do |row|
  final_crate_string += row.last
end

puts final_crate_string