puts "Вас привествует программа квадратное уравнение"
puts "Введите 3 коэффицента"

def coefficient (name)
  puts "Коэффицент #{name} ="
  gets.chomp.to_i
end

a = coefficient "a"
b = coefficient "b"
c = coefficient "c"

d = b**2 - (4 * a * c)

if d < 0
  puts "корней нет"
elsif d == 0
  x1 = ( -b + Math.sqrt(d) ) / 2 * a
  puts "Дискриминант = #{d}, корень = #{x1}"
else
  x1 = ( -b + Math.sqrt(d) ) / 2 * a
  x2 = ( -b - Math.sqrt(d) ) / 2 * a
  puts "Дискриминант = #{d}, корень 1 = #{x1}, корень 2 = #{x2}"
end