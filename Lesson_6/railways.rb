require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'route'
require_relative 'station'
require_relative 'menu_texts'

class RailWaysOld6
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

  def choose_from(variant, list)
    index = nil
    loop do
      stations_list if variant == 'Stations'
      routes_list if variant == 'Routes'
      train_list if variant == 'Trains'
      wagon_list if variant == 'Wagons'
      index = gets.chomp.to_i
      break unless list[index].nil?
    end
    list[index]
  end

  def station_actions(command)
    station_create if command == 1
     if command == 2
       stations_list
       station_actions(paint_menu STATION_MENU)
     end
    main_menu if command == 0
  end

  def station_create
    puts "Введите имя станции"
    name = gets.chomp
    self.stations << Station.new(name)
    station_actions(paint_menu STATION_MENU)
  end

  def stations_list
    puts "Список станций:"
    stations.each_with_index do |station, index|
      puts "#{index} - #{station.name} поезда:"
      station.trains.each_with_index {|train, train_index| puts" #{train_index} -> #{train.number}"}
    end
  end

  def route_actions(command)
    route_create if command == 1
    if command == 2
      routes_list
      route_actions(paint_menu ROUTE_MENU)
    end
    routes_add_station if command == 3
    routes_del_station if command == 4
    main_menu if command == 0
  end

  def route_create
    puts "Выберите начальную станцию"
    first_station = choose_from('Stations', stations)
    puts "Выберите конечную станцию"
    last_station = choose_from('Stations', stations)
    routes << Route.new(first_station, last_station)
    route_actions(paint_menu ROUTE_MENU)
  end

  def routes_list
    puts "Выбрать маршрут:"
    routes.each_with_index do |route, index|
      puts "#{index} - Маршрут #{route.first_station.name} - #{route.last_station.name}:"
      route.print_stations
    end
  end

  def routes_add_station
    puts "Выберите маршрут куда хотите добавить станцию:"
    route = choose_from('Routes', routes)
    puts "Какую станцию добавить"
    station = choose_from('Stations', stations)
    route.add_station(station)
    route_actions(paint_menu ROUTE_MENU)
  end

  def routes_del_station
    puts "Выберите маршрут где хотите удалить станцию:"
    route = choose_from('Routes', routes)
    puts "Какую станцию удалить"
    station = choose_from('Stations', stations)
    route.remove_station(station)
    route_actions(paint_menu ROUTE_MENU)
  end

  def train_actions(command)
    train_create if command == 1
    if command == 2
      train_list
      train_actions(paint_menu TRAIN_MENU)
    end
    train_add_route if command == 3
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

  def train_list
    puts "Список поездов:"
    trains.each_with_index do |train, index|
      puts "#{index} - #{train.number} тип  #{train.class.to_s}"
      puts "текущая станция #{train.station.name}" unless train.station.nil?
      puts "вагонов -> #{train.wagons.size}"
    end
  end

  def train_add_route
    puts "Выберите поезд"
    train = choose_from('Trains', trains)
    puts "Выберите маршрут"
    route = choose_from('Routes', routes)
    train.add_route(route)
    train_actions(paint_menu TRAIN_MENU)
  end

  def train_add_wagon
    puts "Выберите поезд"
    train = choose_from('Trains', trains)
    wagon = choose_from('Wagons', wagons)
    train.attach_wagon(wagon)
    train_actions(paint_menu TRAIN_MENU)
  end

  def train_del_wagon
    puts "Выберите поезд"
    train = choose_from('Trains', trains)
    train.unhitch_wagon
    train_actions(paint_menu TRAIN_MENU)
  end

  def train_travel_forward
    puts "Выберите поезд"
    train = choose_from('Trains', trains)
    train.move_forward
    train_actions(paint_menu TRAIN_MENU)
  end

  def train_travel_back
    puts "Выберите поезд"
    train = choose_from('Trains', trains)
    train.move_back
    train_actions(paint_menu TRAIN_MENU)
  end

  def wagon_list
    puts "Список вагонов"
    wagons.each_with_index { |wagon, index| puts "#{index} - #{wagon.manufacturer}" }
  end

  def seed
    stations << Station.new('Astana')
    stations << Station.new('Almaty')
    stations << Station.new('Balhash')
    routes << Route.new(stations[0], stations[1])
    routes[0].add_station(stations[-1])
    trains << CargoTrain.new('TRAIN-AAA-1')
    trains << CargoTrain.new('TRAIN-SS-1')
    trains[0].add_route(routes[0])
    7.times { wagons << CargoWagon.new('China') }
    6.times { wagons << PassengerWagon.new('Kazakhstan') }
    trains[0].attach_wagon(wagons.first)
  end
end