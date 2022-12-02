input = $stdin.read

points = 0

input.each_line(chomp: true) do |line|
  if line.split.last == 'X'
    points += 1

    if line.split.first == 'A'
      points += 3
    elsif line.split.first == 'C'
      points += 6
    end
  elsif line.split.last == 'Y'
    points += 2

    if line.split.first == 'A'
      points += 6
    elsif line.split.first == 'B'
      points += 3
    end
  else
    points += 3

    if line.split.first == 'B'
      points += 6
    elsif line.split.first == 'C'
      points += 3
    end
  end
end

puts "First part: #{points}"

points = 0

input.each_line(chomp: true) do |line|
  if line.split.first == 'A'
    if line.split.last == 'X'
      points += 3
    elsif line.split.last == 'Y'
      points += 4
    else
      points += 8
    end
  elsif line.split.first == 'B'
    if line.split.last == 'X'
      points += 1
    elsif line.split.last == 'Y'
      points += 5
    else
      points += 9
    end
  else
    if line.split.last == 'X'
      points += 2
    elsif line.split.last == 'Y'
      points += 6
    else
      points += 7
    end
  end
end

puts "Second part: #{points}"
