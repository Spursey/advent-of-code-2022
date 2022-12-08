#frozen_string_literal: true

INPUT_FILE = 'input.txt'

MAX_FILE_SIZE = 100000
TOTAL_DISK_SPACE = 70000000
UNUSED_SPACE_REQUIRED = 30000000

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

directory_sizes_to_consider = []

space_available = TOTAL_DISK_SPACE - file_paths['root'][:total_file_size]
space_needed = UNUSED_SPACE_REQUIRED - space_available

file_paths.each_key do |key|
  directory_size = file_paths[key][:total_file_size]

  next if directory_size < space_needed

  directory_sizes_to_consider << directory_size
end

puts directory_sizes_to_consider.min