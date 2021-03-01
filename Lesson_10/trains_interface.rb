# frozen_string_literal: true

module TrainsInterface
  TRAIN = { 0 => :main_menu,
            1 => :train_processing,
            2 => :train_display,
            3 => :train_add_route,
            4 => :train_add_wagon,
            5 => :train_del_wagon,
            6 => :train_travel_forward,
            7 => :train_travel_back,
            8 => :train_wagons_display }.freeze

  attr_reader :trains

  private

  attr_writer :trains

  def train_actions(command)
    send TRAIN[command]
  rescue NoMethodError
    retry
  end

  def train_display
    trains_list
    train_actions(paint_menu(TRAIN_MENU))
  end

  def train_processing
    attempt ||= 3
    train_get_data
  rescue RuntimeError => e
    attempt -= 1
    puts "#{e.message}, осталось попыток #{attempt}"
    retry if attempt.positive?
    train_actions(paint_menu(TRAIN_MENU))
  end

  def trains_list
    puts 'Список поездов:'
    trains.each_with_index do |train, index|
      train_details(train, index)
    end
  end

  def train_details(train, index)
    puts "#{index} - #{train.number} тип  #{train.class}, шеф поезда #{train.chief}"
    puts "текущая станция #{train.station.name}" unless train.station.nil?
    puts "вагонов -> #{train.wagons.size}"
    puts 'доска почета:'
    puts train.chief_history
  end

  def train_add_route
    puts 'Выберите поезд'
    train = choose_from(:trains, trains)
    puts 'Выберите маршрут'
    route = choose_from(:routes, routes)
    train.add_route(route)
    train_actions(paint_menu(TRAIN_MENU))
  end

  def train_add_wagon
    puts 'Выберите поезд'
    train = choose_from(:trains, trains)
    wagon = choose_from(:cargo_wagons, cargo_wagons) if train.wagon_type == 'cargo'
    wagon = choose_from(:passenger_wagons, passenger_wagons) if train.wagon_type == 'passenger'
    train.attach_wagon(wagon)
    train_actions(paint_menu(TRAIN_MENU))
  end

  def train_del_wagon
    puts 'Выберите поезд'
    train = choose_from(:trains, trains)
    train.unhitch_wagon
    train_actions(paint_menu(TRAIN_MENU))
  end

  def train_travel_forward
    puts 'Выберите поезд'
    train = choose_from(:trains, trains)
    train.move_forward
    train_actions(paint_menu(TRAIN_MENU))
  end

  def train_travel_back
    puts 'Выберите поезд'
    train = choose_from(:trains, trains)
    train.move_back
    train_actions(paint_menu(TRAIN_MENU))
  end

  def train_wagons_display
    puts 'Выберите поезд'
    train = choose_from(:trains, trains)
    puts "Список вагонов поезда #{train.number}:"
    train.all_wagons do |wagon, index|
      puts "#{index} тип #{wagon.model}, вместимость #{wagon.capacity}, свободный объем #{wagon.free_capacity}"
    end
    train_actions(paint_menu(TRAIN_MENU))
  end

  def train_get_data
    puts 'Введите номер поезда'
    number = gets.chomp
    puts TRAIN_WAGON_TYPE
    type = gets.chomp.to_i
    train_create(number, type)
  end

  def train_create(number, type)
    trains << CargoTrain.new(number) if type == 1
    trains << PassengerTrain.new(number) if type == 2
    puts "Поезд #{trains[-1].number} создан"
    train_actions(paint_menu(TRAIN_MENU))
  end
end
