#frozen_string_literal: true

INPUT_FILE = 'input.txt'

tree_file = File.open(INPUT_FILE)

tree_map = []
tree_row_size = 0

File.foreach(INPUT_FILE) do |line|
  tree_map[tree_row_size] = line.chomp.each_char.map { |x| x }

  tree_row_size += 1
end

top_scenic_score = 0

for x in (1..tree_map[0].length - 2)
  for y in (1..(tree_map.map { |x| x.first }.length - 2))
    row = tree_map[x]
    col = tree_map.map { |col| col[y] }

    top  = col[0..(x - 1)]
    left = row[0..(y - 1)]
    right = row[(y + 1)..(row.length - 1)]
    below = col[(x + 1)..(row.length - 1)]

    top_score = 0
    top.reverse.each do |tree|
      top_score += 1

      if tree >= tree_map[x][y]
        break
      end
    end

    left_score = 0
    left.reverse.each do |tree|
      left_score += 1

      if tree >= tree_map[x][y]
        break
      end
    end

    below_score = 0
    below.each do |tree|
      below_score += 1

      if tree >= tree_map[x][y]
        break
      end
    end

    right_score = 0
    right.each do |tree|
      right_score += 1

      if tree >= tree_map[x][y]
        break
      end
    end

    total_current_score = top_score * left_score * below_score * right_score

    top_scenic_score = total_current_score if total_current_score > top_scenic_score
  end
end

puts top_scenic_score