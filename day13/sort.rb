def sorted?(left, right)
  # One side runs out of items
  if right == nil
    return false, true
  elsif left == nil
    return true, true
  end

  # Both sides are arrays
  if left.class == Array && right.class == Array
    [left.count, right.count].max.times do |i|
      result = sorted?(left[i], right[i])
      if result[1]
        return result
      end
    end
    return true, false
  # Both sides are integers
  elsif left.class == Integer && right.class == Integer
    return left <= right, left != right
  end

  # One integer, one array
  if left.class == Integer
    return sorted?([left], right)
  else
    return sorted?(left, [right])
  end
end

input = $stdin.read.split("\n\n")

# Part 1
right_order_indices = []

input.each_index do |i|
  left, right = input[i].lines(chomp: true)
  left = eval(left)
  right = eval(right)

  if sorted?(left, right)[0]
    right_order_indices << i + 1
  end
end

puts "Indices in the right order are #{right_order_indices} for a sum of #{right_order_indices.sum}"

# Part 2
all_packets = [[[2]], [[6]]]
input.each do |pair|
  pair.lines(chomp: true) do |line|
    packet = eval(line)
    all_packets << packet
  end
end

all_packets.sort! do |a, b|
  if sorted?(a, b)[0]
    -1
  else
    1
  end
end

dividers = [all_packets.index([[2]]) + 1, all_packets.index([[6]]) + 1]
puts "Divider packets are at #{dividers} for a result of #{dividers[0] * dividers[1]}"
