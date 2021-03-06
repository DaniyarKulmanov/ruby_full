require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'route'
require_relative 'station'
require_relative 'menu_texts'

class RailWays
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
    when 4 then wagon_actions(paint_menu WAGON_MENU)
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
      trains_list if variant == 'Trains'
      wagon_list if variant == 'Wagons'
      index = gets.chomp.to_i
      break unless list[index].nil?
    end
    list[index]
  end

  def station_actions(command)
    station_processing if command == 1
     if command == 2
       stations_list
       station_actions(paint_menu STATION_MENU)
     end
    station_trains_display if command == 3
    main_menu if command == 0
  end

  def station_processing
    attempt ||= 3
    puts "Введите имя станции"
    name = gets.chomp
    self.stations << Station.new(name)
    puts "Станция #{self.stations[-1].name} создана"
    station_actions(paint_menu STATION_MENU)
  rescue RuntimeError => e
    attempt -= 1
    puts "#{e.message}, осталось попыток #{attempt}"
    retry if attempt > 0
    station_actions(paint_menu STATION_MENU)
  end

  def stations_list
    puts "Список станций:"
    stations.each_with_index do |station, index|
      puts "#{index} - #{station.name} поезда:"
      station.trains.each_with_index {|train, train_index| puts" #{train_index} -> #{train.number}"}
    end
  end

  def station_trains_display
    puts 'Выберите станцию'
    station = choose_from('Stations', stations)
    puts "Список поездов на станции #{station.name}:"
    station.all_trains { |train| puts "Номер поезда - #{train.number}, вагонов #{train.wagons.size}" }
    station_actions(paint_menu STATION_MENU)
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
    train_processing if command == 1
    if command == 2
      trains_list
      train_actions(paint_menu TRAIN_MENU)
    end
    train_add_route if command == 3
    train_add_wagon if command == 4
    train_del_wagon if command == 5
    train_travel_forward if command == 6
    train_travel_back if command == 7
    train_wagons_display if command == 8
    main_menu if command == 0
  end

  def train_processing
    attempt ||= 3
    puts "Введите номер поезда"
    number = gets.chomp
    puts TRAIN_WAGON_TYPE
    type = gets.chomp.to_i
    trains << CargoTrain.new(number) if type == 1
    trains << PassengerTrain.new(number) if type == 2
    puts "Поезд #{trains[-1].number} создан"
    train_actions(paint_menu TRAIN_MENU)
  rescue RuntimeError => e
    attempt -= 1
    puts "#{e.message}, осталось попыток #{attempt}"
    retry if attempt > 0
    train_actions(paint_menu TRAIN_MENU)
  end

  def trains_list
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

  def train_wagons_display
    puts 'Выберите поезд'
    train = choose_from('Trains', trains )
    puts "Список вагонов поезда #{train.number}:"
    train.all_wagons do |wagon , index|
      puts "#{index} тип #{wagon.type}, вместимость #{wagon.capacity}, свободный объем #{wagon.free_capacity}"
    end
    train_actions(paint_menu TRAIN_MENU)
  end

  def wagon_actions(command)
    wagon_processing if command == 1
    if command == 2
      wagon_list
      wagon_actions(paint_menu WAGON_MENU)
    end
    cargo_wagon_reserve_capacity if command == 3
    passenger_wagon_reserve_seats if command == 4
    main_menu if command == 0
  end

  def wagon_processing
    attempt ||= 3
    puts "Какой вагон создать"
    puts TRAIN_WAGON_TYPE
    type = gets.chomp.to_i
    cargo_wagon_create if type == 1
    passenger_wagon_create if type == 2
    wagon_actions(paint_menu WAGON_MENU)
  rescue RuntimeError => e
    attempt -= 1
    puts "#{e.message}, осталось попыток #{attempt}"
    retry if attempt > 0
    wagon_actions(paint_menu WAGON_MENU)
  end

  def cargo_wagon_create
    puts "Укажите объем"
    value = gets.chomp.to_i
    self.wagons << CargoWagon.new( value )
    puts "Вагон #{wagons[-1].type} создан, объем = #{wagons[-1].capacity}"
  end

  def cargo_wagon_reserve_capacity
    puts "Выберите вагон типа cargo!"
    wagon = choose_from('Wagons', wagons)
    if wagon.type == 'cargo'
      puts "Сколько объема занять, укажите числовое значение!"
      capacity = gets.chomp.to_i
      wagon.take_capacity( capacity )
      puts "Осталось объема #{wagon.free_capacity}"
    else
      puts "Вы выбрали не верный тип вагона = #{wagon.type}"
    end
    wagon_actions(paint_menu WAGON_MENU)
  rescue RuntimeError => e
    puts e.message
    wagon_actions(paint_menu WAGON_MENU)
  end

  def passenger_wagon_create
    puts "Укажите количество мест"
    value = gets.chomp.to_i
    self.wagons << PassengerWagon.new( value )
    puts "Вагон #{wagons[-1].type} создан, мест = #{wagons[-1].seats}"
  end

  def passenger_wagon_reserve_seats
    puts "Выберите вагон типа passenger!"
    wagon = choose_from('Wagons', wagons)
    if wagon.type == 'passenger'
      puts "Сколько мест занять, укажите числовое значение!"
      seats = gets.chomp.to_i
      wagon.take_seat( seats )
      puts "Осталось мест #{wagon.free_seats}"
    else
      puts "Вы выбрали не верный тип вагона = #{wagon.type}"
    end
    wagon_actions(paint_menu WAGON_MENU)
  rescue RuntimeError => e
    puts e.message
    wagon_actions(paint_menu WAGON_MENU)
  end

  def wagon_list
    puts "Список вагонов"
    wagons.each_with_index do |wagon, index|
      if wagon.class == CargoWagon
        puts "#{index} - Вагон типа #{wagon.type}, свободный объем: #{wagon.free_capacity}"
      else
        puts "#{index} - Вагон типа #{wagon.type} свободных мест: #{wagon.free_seats}"
      end
    end
  end

  def seed
    stations << Station.new('Астана')
    stations << Station.new('Алматы')
    stations << Station.new('Балхаш')
    routes << Route.new(stations[0], stations[1])
    routes[0].add_station(stations[-1])
    trains << CargoTrain.new('ППШ-16')
    trains << PassengerTrain.new('АТА12')
    trains[0].add_route(routes[0])
    7.times { wagons << CargoWagon.new( rand(100..500),'cargo') }
    6.times { wagons << PassengerWagon.new( rand(300), 'passenger') }
    trains.each do |train|
      wagons.each {|wagon| train.attach_wagon(wagon) if train.wagon_type == wagon.type}
    end
  end
end