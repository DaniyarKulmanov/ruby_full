def enter_side (name)
  puts "Длина стороны #{name} ="
  gets.chomp.to_i
end

puts "Введите три стороны треугольника по очереди."

a = enter_side "A"
b = enter_side "B"
c = enter_side "C"

if a > b && a > c
  puts "Треугольник прямоугольный" if a**2 == b**2 + c**2
elsif b > a && b > c
  puts "Треугольник прямоугольный" if b**2 == a**2 + c**2
elsif c > a && c > b
  puts "Треугольник прямоугольный" if c**2 == b**2 + a**2
elsif a == b && b == c
  puts "Треугольник равносторонний"
end

