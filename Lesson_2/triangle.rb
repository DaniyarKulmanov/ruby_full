puts "Программа вычисления площади треугольника"

puts "Какой длины основание треугольника?"
bottom = gets.chomp.to_i

puts "Какой длины высота треугольника?"
height = gets.chomp.to_i

def count_area ( bottom, height )
  0.5 * bottom * height
end

area = count_area(bottom, height)
puts "Площадь треугольника = #{area}"