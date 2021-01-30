fibonacci = [0,1]

loop do
  sum = fibonacci[-1] + fibonacci[-2]
  break if sum >= 100
  fibonacci << sum
end

puts fibonacci