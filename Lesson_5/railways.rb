require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'route'
require_relative 'station'
require_relative 'menu_texts'

class RailWays
  #TODO создать констатны под тексты
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
    when 1 then station_actions(paint_menu STATION_MENU)
    when 2 then route_actions(paint_menu ROUTE_MENU)
    when 3 then train_actions(paint_menu TRAIN_MENU)
    end
  end

  private

  attr_writer :routes, :stations, :trains, :wagons

  def paint_menu (header)
    command = 0
    loop do
      # system('clear')
      puts header
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
    station_actions(paint_menu STATION_MENU)
  end

  def stations_display
    stations_list
    station_actions(paint_menu STATION_MENU)
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
    route_actions(paint_menu ROUTE_MENU)
  end

  def routes_display
    routes_list
    route_actions(paint_menu ROUTE_MENU)
  end

  def routes_list
    puts "Выбрать маршрут:"
    routes.each_with_index do |route, index|
      puts "#{index} - Станции маршрута:"
      route.stations.each {|station| puts "-> #{station.name}"}
      #TODO список поездов на стнации
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
    route_actions(paint_menu ROUTE_MENU)
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
    route_actions(paint_menu ROUTE_MENU)
  end

  # routes ========
  def train_actions(command)
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