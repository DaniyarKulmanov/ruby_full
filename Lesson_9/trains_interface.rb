# frozen_string_literal: true

module TrainsInterface
  attr_reader :trains

  private

  attr_writer :trains

  def train_actions(command)
    train_create if command == 1
    if command == 2
      train_list
      train_actions(paint_menu(TRAIN_MENU))
    end
    train_add_route if command == 3
    train_add_wagon if command == 4
    train_del_wagon if command == 5
    train_travel_forward if command == 6
    train_travel_back if command == 7
    train_wagons_display if command == 8
    main_menu if command.zero?
  end

  def train_create
    attempt ||= 3
    puts 'Введите номер поезда'
    number = gets.chomp
    puts TRAIN_WAGON_TYPE
    type = gets.chomp.to_i
    trains << CargoTrain.new(number) if type == 1
    trains << PassengerTrain.new(number) if type == 2
    puts "Поезд #{trains[-1].number} создан"
    train_actions(paint_menu(TRAIN_MENU))
  rescue RuntimeError => e
    attempt -= 1
    puts "#{e.message}, осталось попыток #{attempt}"
    retry if attempt.positive?
    train_actions(paint_menu(TRAIN_MENU))
  end

  def train_list
    puts 'Список поездов:'
    trains.each_with_index do |train, index|
      puts "#{index} - #{train.number} тип  #{train.class}"
      puts "текущая станция #{train.station.name}" unless train.station.nil?
      puts "вагонов -> #{train.wagons.size}"
    end
  end

  def train_add_route
    puts 'Выберите поезд'
    train = choose_from('Trains', trains)
    puts 'Выберите маршрут'
    route = choose_from('Routes', routes)
    train.add_route(route)
    train_actions(paint_menu(TRAIN_MENU))
  end

  def train_add_wagon
    puts 'Выберите поезд'
    train = choose_from('Trains', trains)
    wagon = choose_from('Wagons', wagons)
    train.attach_wagon(wagon)
    train_actions(paint_menu(TRAIN_MENU))
  end

  def train_del_wagon
    puts 'Выберите поезд'
    train = choose_from('Trains', trains)
    train.unhitch_wagon
    train_actions(paint_menu(TRAIN_MENU))
  end

  def train_travel_forward
    puts 'Выберите поезд'
    train = choose_from('Trains', trains)
    train.move_forward
    train_actions(paint_menu(TRAIN_MENU))
  end

  def train_travel_back
    puts 'Выберите поезд'
    train = choose_from('Trains', trains)
    train.move_back
    train_actions(paint_menu(TRAIN_MENU))
  end

  def train_wagons_display
    puts 'Выберите поезд'
    train = choose_from('Trains', trains)
    puts "Список вагонов поезда #{train.number}:"
    train.all_wagons do |wagon, index|
      puts "#{index} тип #{wagon.type}, вместимость #{wagon.capacity}, свободный объем #{wagon.free_capacity}"
    end
    train_actions(paint_menu(TRAIN_MENU))
  end
end
