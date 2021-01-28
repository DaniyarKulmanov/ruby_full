puts "Вас привествует программа идеального Веса!"

puts "Здравствуйте как Вас зовут?"
name = gets.chomp.capitalize

puts "Введите Ваш рост"
height = gets.chomp.to_i

def count_weight (height)
  (height - 110) * 1.15
end

best_weight = count_weight(height)

puts "#{name} Ваш идеальный вес = #{best_weight}!" if best_weight > 0
puts "#{name} у Вас оптимальный вес!" if best_weight <= 0
