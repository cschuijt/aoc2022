input = $stdin.read

instructions = input.lines(chomp: true)
cycles = [1]

instructions.each do |instruction|
  if instruction == "noop"
    cycles << cycles.last
  else
    adjustment = instruction.split[1].to_i
    cycles << cycles.last
    cycles << (cycles.last + adjustment)
  end
end

result1 = [cycles[19]  * 20,  cycles[59]  * 60,  cycles[99]  * 100,
           cycles[139] * 140, cycles[179] * 180, cycles[219] * 220].sum

puts "Total of cycles 20, 60, 100, 140, 180 and 220 is #{result1}"

screen = []
240.times do |i|
  if (cycles[i]-1..cycles[i]+1).member?(i % 40)
    screen << "#"
  else
    screen << "."
  end
end

puts screen[0..39].join
puts screen[40..79].join
puts screen[80..119].join
puts screen[120..159].join
puts screen[160..199].join
puts screen[200..239].join
