def visible_from_north(array, height, x, y)
  visible_trees = 0
  y = y - 1

  while y >= 0
    visible_trees = visible_trees + 1
    if array[y][x] >= height
      return false, visible_trees
    end
    y = y - 1
  end
  
  return true, visible_trees
end

def visible_from_east(array, height, x, y)
  visible_trees = 0
  x = x + 1

  while array[y] && array[y][x]
    visible_trees = visible_trees + 1
    if array[y][x] >= height
      return false, visible_trees
    end
    x = x + 1
  end
  
  return true, visible_trees
end

def visible_from_south(array, height, x, y)
  visible_trees = 0
  y = y + 1

  while array[y] && array[y][x]
    visible_trees = visible_trees + 1
    if array[y][x] >= height
      return false, visible_trees
    end
    y = y + 1
  end
  
  return true, visible_trees
end

def visible_from_west(array, height, x, y)
  visible_trees = 0
  x = x - 1

  while x >= 0
    visible_trees = visible_trees + 1
    if array[y][x] >= height
      return false, visible_trees
    end
    x = x - 1
  end
  
  return true, visible_trees
end

input = $stdin.read

array = input.split.map { |line| line.chars.map { |c| c.to_i } }
@visible_trees = 0
@highest_scenic_score = 0
array.each_index do |y|
  array[y].each_index do |x|
    height = array[y][x]

    if visible_from_north(array, height, x, y)[0]
      @visible_trees = @visible_trees + 1
    elsif visible_from_east(array, height, x, y)[0]
      @visible_trees = @visible_trees + 1
    elsif visible_from_south(array, height, x, y)[0]
      @visible_trees = @visible_trees + 1
    elsif visible_from_west(array, height, x, y)[0]
      @visible_trees = @visible_trees + 1
    end

    scenic_score = visible_from_north(array, height, x, y)[1] *
                   visible_from_east(array, height, x, y)[1] * 
                   visible_from_south(array, height, x, y)[1] * 
                   visible_from_west(array, height, x, y)[1]
    if scenic_score > @highest_scenic_score
      @highest_scenic_score = scenic_score
    end
  end
end

puts "Visible trees: #{@visible_trees}"
puts "Highest scenic score: #{@highest_scenic_score}"
