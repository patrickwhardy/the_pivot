filepath = ARGV[0]
array = IO.readlines(filepath)

addresses = []

array.each_with_index do |line, index|
  if index.even?
    address = [array[index].chomp, array[index + 1].chomp].join(", ")
    addresses << address
  end
end

addresses
