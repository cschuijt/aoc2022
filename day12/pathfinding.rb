def run_routing(map, start, finish)
  runners = [
    { x: start[0], y: start[1], steps: 0 }
  ]

  while true
    new_runners = []

    runners.each do |runner|
      if finish == [runner[:x], runner[:y]]
        reset_map(map)
        return runner[:steps]
      end

      if can_move?(map, [runner[:x], runner[:y]], [runner[:x] + 1, runner[:y]])
        new_runners << {
          x: runner[:x] + 1,
          y: runner[:y],
          steps: runner[:steps] + 1
        }
        map[runner[:y]][runner[:x] + 1][:routed] = true
      end

      if can_move?(map, [runner[:x], runner[:y]], [runner[:x], runner[:y] + 1])
        new_runners << {
          x: runner[:x],
          y: runner[:y] + 1,
          steps: runner[:steps] + 1
        }
        map[runner[:y] + 1][runner[:x]][:routed] = true
      end

      if can_move?(map, [runner[:x], runner[:y]], [runner[:x] - 1, runner[:y]])
        new_runners << {
          x: runner[:x] - 1,
          y: runner[:y],
          steps: runner[:steps] + 1
        }
        map[runner[:y]][runner[:x] - 1][:routed] = true
      end

      if can_move?(map, [runner[:x], runner[:y]], [runner[:x], runner[:y] - 1])
        new_runners << {
          x: runner[:x],
          y: runner[:y] - 1,
          steps: runner[:steps] + 1
        }
        map[runner[:y] - 1][runner[:x]][:routed] = true
      end
    end
    
    runners = new_runners
    if runners.empty?
      return nil
    end
  end
end

def can_move?(map, current, target)
  if target[0] < 0 || target[1] < 0
    return false
  end
  if map[target[1]] == nil || map[target[1]][target[0]] == nil
    return false
  end

  current = map[current[1]][current[0]]
  target  = map[target[1]][target[0]]
  if target[:routed]
    return false
  elsif target[:height] - current[:height] > 1
    return false
  end

  return true
end

def reset_map(map)
  map.each do |row|
    row.each do |location|
      location[:routed] = false
    end
  end
end

input = $stdin.read.lines(chomp: true)

map     = []
start   = [0, 0]
finish  = [0, 0]
possible_start_positions = []

input.each_index do |y|
  map << input[y].chars.map do |c|
    location = {}

    location[:height] = c
    location[:routed] = false

    location[:height] = "a" if location[:height] == "S"
    location[:height] = "z" if location[:height] == "E"
    location[:height] = location[:height].ord

    location
  end
  input[y].chars.each_index do |x|
    if input[y][x] == "S"
      start = [x, y]
      possible_start_positions << [x, y]
    elsif input[y][x] == "E"
      finish = [x, y]
    elsif input[y][x] == "a"
      possible_start_positions << [x, y]
    end
  end
end

shortest_route = run_routing(map, start, finish)
puts "Shortest route from original starting location is #{shortest_route}"

possible_start_positions.each do |start_position|
  route = run_routing(map, start_position, finish)
  # puts "Calculated route from #{start_position} of length #{route || "invalid"}"
  if route && route < shortest_route
    shortest_route = route
  end
end

puts "Shortest route from any position at height a is #{shortest_route}"
