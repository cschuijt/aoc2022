def read_folder(lines, i)
  moves = 2
  folder = {}
  while lines[i + moves] && lines[i + moves] != "$ cd .."
    split = lines[i + moves].split

    if split[0].to_i > 0
      folder[split[1]] = split[0].to_i
    elsif split[0] == "$"
      extra_moves, subfolder = read_folder(lines, i + moves)
      folder[split[2]] = subfolder
      moves = moves + extra_moves
    end

    moves = moves + 1;
  end

  return moves, folder
end

def folder_size(folder)
  size = 0

  folder.each do |_, v|
    if v.class == Integer
      size = size + v
    else
      size = size + folder_size(v)
    end
  end

  if size < 100000
    @puzzle_1 = @puzzle_1 + size
  end

  if @total_size && size >= @size_to_free && size < @smallest_possible_deletion
    @smallest_possible_deletion = size
  end

  size
end

input = $stdin.read

lines = input.lines(chomp: true)

_, folders = read_folder(lines, 0)
# pp folders

@puzzle_1 = 0
@total_size = folder_size(folders)

puts "Puzzle 1: #{@puzzle_1}"

@size_to_free = @total_size - 40000000
@smallest_possible_deletion = 70000000
folder_size(folders)
puts "Puzzle 2: #{@smallest_possible_deletion}"
