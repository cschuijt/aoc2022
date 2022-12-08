input = $stdin.read

array = input.chars

array.each_index do |i|
  sub_array = array[i..i+3]
  if sub_array.uniq.length == sub_array.length
    puts "Found key after character #{i + 4}"
    break
  end
end

array.each_index do |i|
  sub_array = array[i..i+13]
  if sub_array.uniq.length == sub_array.length
    puts "Found key after character #{i + 14}"
    break
  end
end
