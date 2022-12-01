input = $stdin.read

elves = Array.new

i = 0
input.each_line(chomp: true) do |line|
  i += line.to_i

  if line.empty?
    elves.append(i)
    i = 0
  end
end

puts elves.max
puts elves.sort.last(3).sum
