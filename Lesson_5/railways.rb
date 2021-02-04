require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'route'
require_relative 'station'

class RailWays
  #TODO создать констатны под тексты
  attr_reader :routes, :stations, :trains, :wagons

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @wagons = []
  end

  def main_menu
    command = paint_menu "Основное меню",
                         "1 - Станции",
                         "2 - Маршруты",
                         "3 - Поезда"
    case command
    when 1
      station_actions paint_menu "Меню станций",
                                 "1 - Создать",
                                 "2 - Просмотр"
    when 2
      route_actions paint_menu "Меню маршрутов",
                               "1 - Создать",
                               "2 - Просмотр"

    when 3
      train_menu paint_menu "Меню поездов",
                         "1 - Создать",
                         "2 - Просмотр"
    end
  end

  private

  attr_writer :routes, :stations, :trains, :wagons

  def paint_menu (header, item1 = nil , item2 = nil, item3 = nil, item4 = nil)
    command = 0
    loop do
      # system('clear')
      puts header, "0 - Выход", item1, item2, item3, item4
      input = gets.chomp
      if input == '0'
        command = input.to_i
        break
      elsif input.to_i.between?(1,3)
        command = input.to_i
        break
      end
    end
    command
  end

  # stations ========
  def station_actions(command)
    station_create if command == 1
    stations_display if  command == 2
    main_menu if command == 0
  end

  def station_create
    puts "Введите имя станции"
    name = gets.chomp
    self.stations << Station.new(name)
    station_actions paint_menu "Меню станций", "1 - Создать", "2 - Просмотр"
  end

  def stations_display
    stations_list
    station_actions paint_menu"Меню станций","1 - Создать","2 - Просмотр"
  end

  def stations_list
    puts "Список станций:"
    stations.each_with_index do |station, index|
      puts "#{index} - #{station.name}"
    end
  end
  # stations ========

  # routes ========
  def route_actions(command)
    route_create if command == 1
    routes_display if  command == 2
    main_menu if command == 0
  end
  # routes ========

  def route_create
    puts "Выберите начальную станцию"
    stations_list
    index = gets.chomp.to_i
    first_station = stations[index]

    puts "Выберите конечную станцию"
    stations_list
    index = gets.chomp.to_i
    last_station = stations[index]

    routes << Route.new(first_station, last_station)
    route_actions paint_menu "Меню маршрутов",
                             "1 - Создать",
                             "2 - Просмотр"
  end

  def routes_display

  end

  def train_menu(command)
  end
end