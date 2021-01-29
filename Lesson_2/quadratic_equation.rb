puts "Вас привествует программа квадратное уравнение"
puts "Введите 3 коэффицента"

def coefficient (name)
  puts "Длина стороны #{name} ="
  gets.chomp.to_i
end

a = coefficient "a"
b = coefficient "b"
c = coefficient "c"

