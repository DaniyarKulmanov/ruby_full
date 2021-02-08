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

  def paint_menu(list_actions)
    command = 0
    loop do
      puts list_actions
      input = gets.chomp
      if input == '0' || input.to_i < list_actions.size - 1
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
    train_create if command == 1
    train_display if command == 2
    train_route if command == 3
    train_add_wagon if command == 4
    train_del_wagon if command == 5
    train_travel_forward if command == 6
    train_travel_back if command == 7
    main_menu if command == 0
  end

  def train_create
    puts "Введите номер поезда"
    number = gets.chomp
    puts TRAIN_TYPE
    type = gets.chomp.to_i
    trains << CargoTrain.new(number) if type == 1
    trains << PassengerTrain.new(number) if type == 2
    train_actions(paint_menu TRAIN_MENU)
  end

  def train_display
    train_list
    train_actions(paint_menu TRAIN_MENU)
  end

  def train_list
    puts "Список поездов:"
    trains.each_with_index do |train, index|
      puts "#{index} - #{train.number} тип  #{train.class.to_s}"
      puts "текущая станция #{train.station.name}" unless train.station.nil?
      puts "вагонов -> #{train.wagons.size}"
    end
  end

  def train_route #TODO проверка на ввод?
    train_list
    train_index = gets.chomp.to_i
    routes_list
    route_index = gets.chomp.to_i
    trains[train_index].add_route(routes[route_index])
    train_actions(paint_menu TRAIN_MENU)
  end

  def train_add_wagon
    train_list
    train_index = gets.chomp.to_i
    wagon_list
    wagon_index = gets.chomp.to_i
    trains[train_index].attach_wagon(wagons[wagon_index])
    train_actions(paint_menu TRAIN_MENU)
  end

  def train_del_wagon
    train_list
    train_index = gets.chomp.to_i
    trains[train_index].unhitch_wagon
    train_actions(paint_menu TRAIN_MENU)
  end

  def train_travel_forward
    train_list
    train_index = gets.chomp.to_i
    trains[train_index].move_forward
    train_actions(paint_menu TRAIN_MENU)
  end

  def train_travel_back
    train_list
    train_index = gets.chomp.to_i
    trains[train_index].move_back unless trains[train_index].nil?
    train_actions(paint_menu TRAIN_MENU)
  end

  # wagons ========
  def wagon_list
    puts "Список вагонов"
    wagons.each_with_index { |wagon, index| puts "#{index} - #{wagon.manufacturer}" }
  end
  # wagons ========

  def seed
    stations << Station.new('Astana')
    stations << Station.new('Almaty')
    stations << Station.new('Balhash')
    routes << Route.new(stations[0], stations[1])
    routes[0].add_station(stations[-1])
    trains << CargoTrain.new('TRAIN-AAA-1')
    trains << CargoTrain.new('TRAIN-SS-1')
    trains[0].add_route(routes[0])
    10.times { wagons << CargoWagon.new('China') }
    10.times { wagons << PassengerWagon.new('Kazakhstan') }
    trains[0].attach_wagon(wagons.first)
  end
end