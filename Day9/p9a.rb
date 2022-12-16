#frozen_string_literal: true

INPUT_FILE = 'input.txt'
GRID_SIDE_LENGTH = 5

def draw_grid(grid, h_loc, t_loc)
  (0..4).each do |x|
    (0..5).each do |y|
      if [x, y] == h_loc
        print 'H'
      elsif [x, y] == t_loc
        print 'T'
      elsif [x, y] == [4, 0]
        print 's'
      else
        print '.'
      end
    end
    print "\n"
  end
  print "\n"
end

movements_file = File.open(INPUT_FILE)

t_location = [4, 0]
h_location = [4, 0]
t_visited_locations = []

grid = Array.new(4)
grid.each_with_index do |space, index|
  grid[index] = Array.new(5)
end

File.foreach(INPUT_FILE) do |line|
  direction, length = line.split(' ')
  length = length.to_i



  #puts "Move: #{direction} #{length}"
  #puts "-----------\n"
  #puts "H: #{h_location}"
  #puts "T: #{t_location}"
  
  i = 0
  while i < length do
    case direction
    when 'R'
      h_location[1] += 1

      if (h_location[0] == t_location[0]) && ((h_location[1] - t_location[1]).abs > 1)
        t_location[1] += 1
      elsif (h_location[0] > t_location[0]) && ((h_location[1] - t_location[1]).abs > 1) 
        t_location[1] += 1
        t_location[0] += 1
      elsif (h_location[0] < t_location[0]) && ((h_location[1] - t_location[1]).abs > 1) 
        t_location[1] += 1
        t_location[0] -= 1
      end
    when 'U'
      h_location[0] -= 1

      if (h_location[1] == t_location[1]) && ((h_location[0] - t_location[0]).abs > 1)
        t_location[0] -= 1
      elsif (h_location[1] > t_location[1]) && ((h_location[0] - t_location[0]).abs > 1) 
        t_location[0] -= 1
        t_location[1] += 1
      elsif (h_location[1] < t_location[1]) && ((h_location[0] - t_location[0]).abs > 1)
        t_location[0] -= 1
        t_location[1] += 1
      end
    when 'L'
      h_location[1] -= 1

      if (h_location[0] == t_location[0]) && ((h_location[1] - t_location[1]).abs > 1)
        t_location[1] -= 1
      elsif (h_location[0] > t_location[0]) && ((h_location[1] - t_location[1]).abs > 1)
        t_location[0] += 1
        t_location[1] -= 1
      elsif (h_location[0] < t_location[0]) && ((h_location[1] - t_location[1]).abs > 1)
        t_location[0] -= 1
        t_location[1] -= 1
      end
    when 'D'
      h_location[0] += 1

      if (h_location[1] == t_location[1]) && ((h_location[0] - t_location[0]).abs > 1)
        t_location[0] += 1
      elsif (h_location[1] > t_location[1]) && ((h_location[0] - t_location[0]).abs > 1)
        t_location[0] += 1
        t_location[1] += 1
      elsif (h_location[1] < t_location[1]) && ((h_location[0] - t_location[0]).abs > 1)
        t_location[0] += 1
        t_location[1] -= 1
      end
    end

    i += 1
    t_visited_locations << [t_location[0], t_location[1]]
    #draw_grid(grid, h_location, t_location)
  end
end

puts t_visited_locations.uniq.length