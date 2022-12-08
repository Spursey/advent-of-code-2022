#frozen_string_literal: true

INPUT_FILE = 'input.txt'
MAX_FILE_SIZE = 100000

current_dir = nil
directory_tree = []

file_paths = Hash.new
file_paths['root'] = {
  total_file_size: 0
}

File.foreach(INPUT_FILE) do |line|
  if line[0] == '$'
    command = line.split(' ')[1]

    if command == 'cd'
      new_dir = line.split(' ')[2]

      if new_dir == '..'
        directory_tree.pop
      else
        if line.split(' ')[2] == '/'
          directory_tree << 'root' 
        else
          directory_tree << new_dir 
        end
      end
    elsif command == 'ls'
      next
    end
  else
    if line[0..2] == 'dir'
      file_paths[directory_tree.join('/') + '/' + line.split(' ')[1]] = {
        total_file_size: 0
      }
    else
      path = ''
      directory_tree.each do |item|
         
        if item == 'root'
          path = 'root'
        else
          path = path + '/' + item
        end

        file_paths[path][:total_file_size] += line.split(' ')[0].to_i
      end
    end
  end
end

total = 0
file_paths.each_key do |key|
  total += file_paths[key][:total_file_size] if file_paths[key][:total_file_size] <= MAX_FILE_SIZE
end

puts total