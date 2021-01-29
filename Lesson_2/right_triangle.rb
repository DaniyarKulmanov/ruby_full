def enter_side (name)
  puts "Длина стороны #{name} ="
  gets.chomp.to_i
end

def equilateral (a,b,c)
  a == b && b == c
end


def find_hypotenuse (a,b,c)
  if a > b && a > c
    a
  elsif b > a && b > c
    b
  elsif c > a && c > b
    c
  else
    false
  end
end

puts "Введите три стороны треугольника по очереди."

side_a = enter_side "A"
side_b = enter_side "B"
side_c = enter_side "C"

# check equilateral?
if equilateral side_a, side_b, side_c
  puts "Треугольник равносторонний"
end

hypotenuse = find_hypotenuse side_a, side_b, side_c
if hypotenuse != false

end
