stacks = [
  ['R', 'H', 'M', 'P','Z'],
  ['B', 'J', 'C', 'P'],
  ['D', 'C', 'L', 'G', 'H', 'N', 'S'],
  ['L', 'R', 'S', 'Q', 'D', 'M', 'T', 'F'],
  ['M', 'Z', 'T', 'B', 'Q', 'P', 'S', 'F'],
  ['G', 'B', 'Z', 'S', 'F', 'T'],
  ['V', 'R', 'N'],
  ['M', 'C', 'V', 'D', 'T', 'L', 'G', 'P'],
  ['L', 'M', 'F', 'J', 'N', 'Q', 'W']
]

input = $stdin.read

input.lines(chomp: true).drop(10).each do |line|
  split = line.split
  amount_to_move = split[1].to_i
  from           = split[3].to_i - 1
  to             = split[5].to_i - 1

  while amount_to_move > 0
    element = stacks[from].shift
    stacks[to].unshift(element)
    amount_to_move -= 1
  end
end

puts "Part one:"
puts stacks.map { |s| s[0]}

stacks_2 = [
  ['R', 'H', 'M', 'P','Z'],
  ['B', 'J', 'C', 'P'],
  ['D', 'C', 'L', 'G', 'H', 'N', 'S'],
  ['L', 'R', 'S', 'Q', 'D', 'M', 'T', 'F'],
  ['M', 'Z', 'T', 'B', 'Q', 'P', 'S', 'F'],
  ['G', 'B', 'Z', 'S', 'F', 'T'],
  ['V', 'R', 'N'],
  ['M', 'C', 'V', 'D', 'T', 'L', 'G', 'P'],
  ['L', 'M', 'F', 'J', 'N', 'Q', 'W']
]

input.lines(chomp: true).drop(10).each do |line|
  split = line.split
  amount_to_move = split[1].to_i
  from           = split[3].to_i - 1
  to             = split[5].to_i - 1


  elements = stacks_2[from].shift(amount_to_move)
  elements.reverse.each do |element|
    stacks_2[to].unshift(element)
  end
end

puts "Part two:"
puts stacks_2.map { |s| s[0]}
