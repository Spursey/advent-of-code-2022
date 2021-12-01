depths = []

File.open('input/input.txt', 'r') do |f|
  f.each_line do |line|
    depths << line.to_i
  end
end

previous_depth = 0
current_depth = 0

depth_increases = 0

depths.each do |depth|
  if depths.first == depth
    previous_depth = depth
    next
  end

  current_depth = depth
  if current_depth > previous_depth
    depth_increases += 1
  end

  previous_depth = current_depth
  current_depth = 0
end

print depth_increases
