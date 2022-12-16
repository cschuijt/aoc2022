def extend_columns_to(columns, col_bounds, x)
  if x < col_bounds[0]
    (col_bounds[0] - x).times do
      columns.unshift ["."]
    end
    col_bounds[0] = x
  elsif x > col_bounds[1]
    (x - col_bounds[1]).times do
      columns << ["."]
    end
    col_bounds[1] = x
  end
end

def draw_line(columns, col_bounds, start, finish)
  extend_columns_to(columns, col_bounds, start[0])
  extend_columns_to(columns, col_bounds, finish[0])

  if start[0] == finish[0]
    draw_vertical_line(columns, col_bounds, start[0], start[1], finish[1])
  elsif start[1] == finish[1]
    draw_horizontal_line(columns, col_bounds, start[1], start[0], finish[0])
  end
end

def draw_horizontal_line(columns, col_bounds, y, start, finish)
  ([start, finish].min..[start, finish].max).each do |column|
    draw_vertical_line(columns, col_bounds, column, y, y)
  end
end

def draw_vertical_line(columns, col_bounds, x, start, finish)
  column = columns[x - col_bounds[0]]
  if [start, finish].max > column.size
    ([start, finish].max - column.size).times do
      column << "."
    end
  end

  ([start, finish].min..[start, finish].max).each do |p|
    column[p] = "#"
  end
end

def simulate_sand(columns, col_bounds)
  sand_location = [500 - col_bounds[0], 0]
  while true
    if columns[sand_location[0]][sand_location[1] + 1] == nil
      # Sand goes out of bounds down
      return false
    elsif columns[sand_location[0]][sand_location[1] + 1] == "."
      # Sand falls straight down
      sand_location[1] = sand_location[1] + 1
    elsif sand_location[0] - 1 < 0 ||
          columns[sand_location[0] - 1][sand_location[1] + 1] == nil
      # Sand goes out of bounds left
      return false
    elsif columns[sand_location[0] - 1][sand_location[1] + 1] == "."
      # Sand falls down to the left
      sand_location = [sand_location[0] - 1, sand_location[1] + 1]
    elsif columns[sand_location[0] + 1] == nil ||
          columns[sand_location[0] + 1][sand_location[1] + 1] == nil
      # Sand goes out of bounds right
      return false
    elsif columns[sand_location[0] + 1][sand_location[1] + 1] == "."
      # Sand falls down to the right
      sand_location = [sand_location[0] + 1, sand_location[1] + 1]
    else
      # This unit of sand is done falling
      columns[sand_location[0]][sand_location[1]] = "o"
      return true
    end
  end
end

# For funsies:
def print_map(columns)
  deepest_col = columns.map { |c| c.count }.max

  deepest_col.times do |y|
    columns.each do |col|
      print (col[y] || ".")
    end
    print "\n"
  end
end

input = $stdin.read.lines(chomp: true)

@columns = [
  ["+"]
]
@col_bounds = [500, 500]

input.each do |line|
  array = line.split(" -> ").map do |pair|
    pair.split(",").map do |s| s.to_i end
  end

  (array.count - 1).times do |i|
    draw_line(@columns, @col_bounds, array[i], array[i + 1])
  end
end

# Part 1

sand_dropped = 0

while simulate_sand(@columns, @col_bounds)
  sand_dropped = sand_dropped + 1
end

# print_map(@columns)
puts "#{sand_dropped} units of sand dropped for part 1"

# Part 2

deepest_col = @columns.map { |c| c.count }.max
extend_columns_to(@columns, @col_bounds, 500 + deepest_col + 2)
extend_columns_to(@columns, @col_bounds, 500 - deepest_col - 2)

@columns.each do |column|
  (deepest_col + 2 - column.size).times do
    column << "."
  end
  column[deepest_col + 1] = "#"
end

while @columns[500 - @col_bounds[0]][0] == "+"
  simulate_sand(@columns, @col_bounds)
  sand_dropped = sand_dropped + 1
end

# print_map(@columns)
puts "#{sand_dropped} units of sand dropped for part 2"
