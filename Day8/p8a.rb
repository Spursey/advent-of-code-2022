#frozen_string_literal: true

INPUT_FILE = 'input.txt'

tree_file = File.open(INPUT_FILE)

tree_map = []
tree_row_size = 0

File.foreach(INPUT_FILE) do |line|
  tree_map[tree_row_size] = line.chomp.each_char.map { |x| x }

  tree_row_size += 1
end

visible_tree_count = (tree_map[0].length - 1) * 4

for x in (1..tree_map[0].length - 2)
  for y in (1..(tree_map.map { |x| x.first }.length - 2))
    row = tree_map[x]
    col = tree_map.map { |col| col[y] }

    top  = col[0..(x - 1)]
    left = row[0..(y - 1)]
    right = row[(y + 1)..(row.length - 1)]
    below = col[(x + 1)..(row.length - 1)]

    top_visible = true
    left_visible = true
    right_visible = true
    below_visible = true

    top.each do |tree|
      if tree >= tree_map[x][y]
        top_visible = false
      end
    end

    left.each do |tree|
      if tree >= tree_map[x][y]
        left_visible = false
      end
    end

    right.each do |tree|
      if tree >= tree_map[x][y]
        right_visible = false
      end
    end

    below.each do |tree|
      if tree >= tree_map[x][y]
        below_visible = false
      end
    end

    visible_tree_count += 1 if top_visible   ||
                               left_visible  ||
                               right_visible ||
                               below_visible
  end
end

puts visible_tree_count