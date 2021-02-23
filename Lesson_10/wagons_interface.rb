# frozen_string_literal: true

module WagonsInterface
  WAGON = { 0 => :main_menu,
            1 => :wagon_processing,
            2 => :wagon_display,
            3 => :cargo_wagon_reserve_capacity,
            4 => :passenger_wagon_reserve_seats }.freeze

  attr_reader :cargo_wagons, :passenger_wagons

  private

  attr_writer :cargo_wagons, :passenger_wagons

  def wagon_actions(command)
    send WAGON[command]
  rescue NoMethodError
    retry
  end

  def wagon_processing
    attempt ||= 3
    wagon_create
  rescue RuntimeError => e
    attempt -= 1
    puts "#{e.message}, осталось попыток #{attempt}"
    retry if attempt.positive?
    wagon_actions(paint_menu(WAGON_MENU))
  end

  def wagon_display
    cargo_wagon_list
    passenger_wagon_list
    wagon_actions(paint_menu(WAGON_MENU))
  end

  def cargo_wagon_create
    puts 'Укажите объем'
    value = gets.chomp.to_i
    cargo_wagons << CargoWagon.new(value)
    puts "Вагон #{wagons[-1].type} создан, объем = #{wagons[-1].capacity}"
  end

  def cargo_wagon_reserve_capacity
    puts 'Выберите вагон.'
    wagon = choose_from(:cargo_wagons, cargo_wagons)
    reserve_capacity(wagon)
    wagon_actions(paint_menu(WAGON_MENU))
  rescue RuntimeError => e
    puts e.message
    wagon_actions(paint_menu(WAGON_MENU))
  end

  def reserve_capacity(wagon)
    puts 'Сколько объема занять, укажите числовое значение!'
    capacity = gets.chomp.to_i
    wagon.take_capacity(capacity)
    puts "Осталось объема #{wagon.free_capacity}"
  end

  def passenger_wagon_create
    puts 'Укажите количество мест'
    value = gets.chomp.to_i
    passenger_wagons << PassengerWagon.new(value)
    puts "Вагон #{wagons[-1].type} создан, мест = #{wagons[-1].seats}"
  end

  def passenger_wagon_reserve_seats
    puts 'Выберите вагон типа passenger!'
    wagon = choose_from(:passenger_wagons, passenger_wagons)
    reserve_seat(wagon)
    wagon_actions(paint_menu(WAGON_MENU))
  rescue RuntimeError => e
    puts e.message
    wagon_actions(paint_menu(WAGON_MENU))
  end

  def reserve_seat(wagon)
    puts 'Сколько мест занять, укажите числовое значение!'
    seats = gets.chomp.to_i
    wagon.take_seat(seats)
    puts "Осталось мест #{wagon.free_seats}"
  end

  def cargo_wagon_list
    puts 'Список грузовых вагонов'
    cargo_wagons.each_with_index do |wagon, index|
      puts "#{index} - Вагон типа #{wagon.type}, свободный объем: #{wagon.free_capacity}"
    end
  end

  def passenger_wagon_list
    puts 'Список пассажирских вагонов'
    passenger_wagons.each_with_index do |wagon, index|
      puts "#{index} - Вагон типа #{wagon.type} свободных мест: #{wagon.free_seats}"
    end
  end

  def wagon_create
    puts 'Какой вагон создать'
    puts TRAIN_WAGON_TYPE
    type = gets.chomp.to_i
    cargo_wagon_create if type == 1
    passenger_wagon_create if type == 2
    wagon_actions(paint_menu(WAGON_MENU))
  end
end
