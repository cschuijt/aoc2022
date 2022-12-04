input = $stdin.read

fully_contained = 0
overlapping = 0

input.each_line(chomp: true) do |line|
  a, b = line.split(",")
  a1, a2 = a.split("-").map(&:to_i)
  b1, b2 = b.split("-").map(&:to_i)
  a_range = a1..a2
  b_range = b1..b2
  if a_range.cover?(b_range) || b_range.cover?(a_range)
    fully_contained += 1
  end
  a_range.each do |i|
    if b_range.include?(i)
      overlapping += 1
      break
    end
  end
end

puts fully_contained
puts overlapping
