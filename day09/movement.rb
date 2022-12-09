def needs_to_move(head, tail)
  if ((tail[0]-1)..(tail[0]+1)).member?(head[0]) && ((tail[1]-1)..(tail[1]+1)).member?(head[1])
    return false
  else
    return true
  end
end

def diagonal_move_tail(head, tail)
  if (head[0] - tail[0]).abs > (head[1] - tail[1]).abs
    tail[1] = head[1]
  else
    tail[0] = head[0]
  end
end

def lateral_move_tail(head, tail)
  if head[0] == tail[0]
    if head[1] > tail[1]
      tail[1] = head[1] - 1
    else
      tail[1] = head[1] + 1
    end
  elsif head[1] == tail[1]
    if head[0] > tail[0]
      tail[0] = head[0] - 1
    else
      tail[0] = head[0] + 1
    end
  end
end

input = $stdin.read
instructions = input.lines(chomp: true)

@head = [0, 0]
@tail = [0, 0]
@coordinates = [[0, 0]]

instructions.each do |instruction|
  instruction.split[1].to_i.times do
    if instruction.split[0] == "U"
      @head[1] = @head[1] - 1
    elsif instruction.split[0] == "D"
      @head[1] = @head[1] + 1
    elsif instruction.split[0] == "L"
      @head[0] = @head[0] - 1
    elsif instruction.split[0] == "R"
      @head[0] = @head[0] + 1
    end

    if needs_to_move(@head, @tail)
      if ((@head[0] - @tail[0]).abs > 1 || (@head[1] - @tail[1]).abs > 1)
        diagonal_move_tail(@head, @tail)
      end
      lateral_move_tail(@head, @tail)
      @coordinates.push([@tail[0], @tail[1]])
    end
  end
end

puts "#{@coordinates.uniq.count} unique coordinates visited"

@links = [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]
@coordinates_part_two = [[0, 0]]

instructions.each do |instruction|
  instruction.split[1].to_i.times do
    if instruction.split[0] == "U"
      @links[0][1] = @links[0][1] - 1
    elsif instruction.split[0] == "D"
      @links[0][1] = @links[0][1] + 1
    elsif instruction.split[0] == "L"
      @links[0][0] = @links[0][0] - 1
    elsif instruction.split[0] == "R"
      @links[0][0] = @links[0][0] + 1
    end
    
    9.times do |i|
      if needs_to_move(@links[i], @links[i + 1])
        if ((@links[i][0] - @links[i + 1][0]).abs > 1 || (@links[i][1] - @links[i + 1][1]).abs > 1)
          diagonal_move_tail(@links[i], @links[i + 1])
        end
        lateral_move_tail(@links[i], @links[i + 1])
        if i == 8
          @coordinates_part_two.push([@links[i + 1][0], @links[i + 1][1]])
        end
      end
    end
  end
end

puts "#{@coordinates_part_two.uniq.count} unique coordinates visited"
# pp @coordinates_part_two
# pp @links
# 2459 too low
# 6087 too high
