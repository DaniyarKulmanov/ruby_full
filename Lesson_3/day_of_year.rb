months = {
  1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30,
  7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31
}
def input (text)
  puts text
  gets.chomp.to_i
end

def leap_year (year)
  year % 4 == 0 && year % 100 != 0 || year % 400 == 0
end


day = input "Введите номер дня:"
month = input "Введите месяц:"
year = input "Введите год:"

year_days = 365 if leap_year(year) == false
year_days = 366 if leap_year(year) == true

day_number = year_days - (day + months[month])

puts "Номер дня в году = #{day_number}"