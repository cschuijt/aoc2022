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

print_map(@columns)
