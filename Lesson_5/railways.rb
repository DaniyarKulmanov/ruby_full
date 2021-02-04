require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'route'
require_relative 'station'

class RailWays
  #TODO создать констатны под тексты
  MAIN_MENU = ['Основное меню',  '1 - Станции', '2 - Маршруты', '3 - Поезда']
  attr_reader :routes, :stations, :trains, :wagons

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @wagons = []
    seed
  end

  def main_menu
    command = paint_menu MAIN_MENU
    
    case command
    when 1
      station_actions paint_menu "Меню станций",
                                 "1 - Создать",
                                 "2 - Просмотр"
    when 2
      route_actions paint_menu "Меню маршрутов",
                               "1 - Создать",
                               "2 - Просмотр",
                               "3 - Добавить стнацию",
                               "4 - Удалить станцию"

    when 3
      train_menu paint_menu "Меню поездов",
                             "1 - Создать",
                             "2 - Просмотр",
                             "3 - Назначить маршрут поезду",
                             "4 - Добавить вагон поезду"
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
      elsif input.to_i.between?(1,4)
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
    routes_display if command == 2
    routes_add_station if command == 3
    routes_del_station if command == 4
    main_menu if command == 0
  end

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
    routes_list
    route_actions paint_menu"Меню маршрутов",
                             "1 - Создать",
                             "2 - Просмотр",
                             "3 - Добавить стнацию",
                             "4 - Удалить станцию"
  end

  def routes_list
    puts "Выбрать маршрут:"
    routes.each_with_index do |route, index|
      puts "#{index} - Станции маршрута:"
      route.stations.each {|station| puts "-> #{station.name}"}
    end
  end

  def routes_add_station
    puts "Выберите маршрут куда хотите добавить станцию:"
    routes_list
    route_index = gets.chomp.to_i

    puts "Какую станцию добавить"
    stations_list
    station_index = gets.chomp.to_i

    routes[route_index].add_station(stations[station_index])
    route_actions paint_menu"Меню маршрутов",
                            "1 - Создать",
                            "2 - Просмотр",
                            "3 - Добавить стнацию",
                            "4 - Удалить станцию"
  end

  def routes_del_station
    puts "Выберите маршрут где хотите удалить станцию:"
    routes_list
    route_index = gets.chomp.to_i

    puts "Какую станцию удалить"
    routes[route_index].stations.each_with_index { |station, index| puts"#{index} - #{station.name}" }
    station_index = gets.chomp.to_i
    station_to_delete = routes[route_index].stations[station_index]

    routes[route_index].remove_station(station_to_delete)
    route_actions paint_menu"Меню маршрутов",
                            "1 - Создать",
                            "2 - Просмотр",
                            "3 - Добавить стнацию",
                            "4 - Удалить станцию"
  end

  # routes ========
  def train_menu(command)
  end

  def seed
    stations << Station.new('Astana')
    stations << Station.new('Almaty')
    stations << Station.new('Balhash')
    routes << Route.new(stations[0], stations[1])
    routes[0].add_station(stations[-1])
    train1 = CargoTrain.new 'TRAIN-AAA-1'
    train1.add_route(routes[0])
  end
end