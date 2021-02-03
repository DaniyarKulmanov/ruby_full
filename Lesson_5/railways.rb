class RailWays
  attr_reader :routes, :stations, :trains, :wagons

  def launch_program
    loop do
      puts "Добро пожаловать в Железную Дорогу!",
           "Введите номер меню для дальнейших действий:",
           "1 - Станции",
           "2 - Маршруты",
           "3 - Поезда",
           "0 - Выход"
      input = gets.chomp
      if input == '0'
        break
      elsif input.to_i.between?(1,3)
        sub_menu(input.to_i)
      end
    end
  end

  private

  attr_writer :routes, :stations, :trains, :wagons

  def sub_menu(input)
    stations if input == 1
    routes if input == 2
    trains if input == 3
  end

  def stations
    puts 'stations'
  end

  def routes
    puts 'routes'
  end

  def trains
    puts 'trains'
  end
end